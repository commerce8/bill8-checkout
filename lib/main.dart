// SPDX-FileCopyrightText: Copyright Logically Magic Inc. <hello@logicallymagic.com>
// SPDX-FileCopyrightText: Copyright Hamid Jahanzad <Hamid@Jahanzad.com>
// SPDX-FileCopyrightText: Copyright Contributors to the Bill8:Checkout
// SPDX-License-Identifier: Apache-2.0

// Bill8:Checkout - main entry point.
//
// The hosted checkout surface: a customer completes a payment session
// (card, wallet, bank debit) created by the merchant through
// Bill8:Checkout's session API. All API traffic routes through
// BffApiClient → Sentin8:BFF /proxy/checkout/... (the platform BFF
// pattern - tokens never reach the client).

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:sentin8/sentin8.dart';
import 'pages/checkout_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Semantics for e2e/Playwright ARIA access.
  SemanticsBinding.instance.ensureSemantics();
  runApp(const CheckoutApp());
}

/// Root widget - resolves the runtime context, then the checkout form.
class CheckoutApp extends StatelessWidget {
  const CheckoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bill8 Checkout',
      debugShowCheckedModeBanner: false,
      theme: sentin8Theme(),
      home: const CheckoutPage(),
    );
  }
}