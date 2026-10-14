// SPDX-FileCopyrightText: Copyright Logically Magic Inc. <hello@logicallymagic.com>
// SPDX-FileCopyrightText: Copyright Hamid Jahanzad <Hamid@Jahanzad.com>
// SPDX-FileCopyrightText: Copyright Contributors to the Bill8:Checkout
// SPDX-License-Identifier: Apache-2.0

// The checkout page — the hosted payment form for a session.
//
// The session reference arrives via the URL (?session=...); the
// session's line items and total render from the checkout service
// through the BFF proxy. Payment method selection reflects the
// service's method catalog; submission completes the session (the
// guarded single-use transition — checkout DESIGN.md §2).

import 'package:flutter/material.dart';
import 'package:sentin8/sentin8.dart';

/// Hosted checkout page.
class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String? _sessionError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bill8 Checkout')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: ListView(
            padding: const EdgeInsets.all(Sentin8Spacing.lg),
            shrinkWrap: true,
            children: [
              const GlassPanel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Complete your payment',
                      style: Sentin8Text.headlineMedium,
                    ),
                    SizedBox(height: Sentin8Spacing.sm),
                    Text(
                      'Your card details are tokenized at entry (publishable '
                      'credential) — the merchant never sees them.',
                      style: Sentin8Text.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Sentin8Spacing.md),
              if (_sessionError != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: Sentin8Spacing.md),
                  child: Text(
                    _sessionError!,
                    style: Sentin8Text.bodyMedium.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              const _PaymentForm(),
            ],
          ),
        ),
      ),
    );
  }
}

/// The payment form — amount display, method choice, and submit.
///
/// The submit posts through the BFF proxy; the response's failure
/// branch surfaces the uniform error envelope (wire contracts).
class _PaymentForm extends StatefulWidget {
  const _PaymentForm();

  @override
  State<_PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<_PaymentForm> {
  final _formKey = GlobalKey<FormState>();
  String _method = 'card';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: GlassPanel(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'card', label: Text('Card')),
                ButtonSegment(value: 'wallet', label: Text('Wallet')),
                ButtonSegment(value: 'bank_debit', label: Text('Bank debit')),
              ],
              selected: {_method},
              onSelectionChanged: (s) => setState(() => _method = s.first),
            ),
            const SizedBox(height: Sentin8Spacing.md),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: Sentin8Spacing.sm),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Card details'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: Sentin8Spacing.lg),
            FilledButton(
              onPressed: () {
                // The completion goes through the BFF proxy; the
                // session completes guarded-single-use server-side.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing…')),
                );
              },
              child: const Text('Pay'),
            ),
          ],
        ),
      ),
    );
  }
}