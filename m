Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262789AbSLXNZc>; Tue, 24 Dec 2002 08:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263326AbSLXNZc>; Tue, 24 Dec 2002 08:25:32 -0500
Received: from libra.i-cable.com ([203.83.111.73]:38890 "HELO
	libra.i-cable.com") by vger.kernel.org with SMTP id <S262789AbSLXNZc>;
	Tue, 24 Dec 2002 08:25:32 -0500
From: "Sampson Fung" <sampson@attglobal.net>
To: <linux-kernel@vger.kernel.org>
Subject: Additional Bug Found--RE: How to help new comers trying the v2.5x series kernels.
Date: Tue, 24 Dec 2002 21:33:36 +0800
Message-ID: <006901c2ab51$10216580$0100a8c0@noelpc>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <20021221190503.GA1508@mars.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After successfully compile and install the "make defconfig" of kernel
2.5.52, I got a strange keyboard problem.

I am using a standard 104 keys keyboard from Compaq.

I and having problems with the <'> (single quote) and <`> (back tick)
key.
The same problem exist for <"> (double quote) and <~> (tile) key.

The problem is, when I press any one of the above keys, continously, the
character will not show up in console.  One and only one pressed key
shows up once I press a different key other than the above 4.

All other keys are OK.  (I don't know how to test the Function keys!)

Any hints?

Sampson Fung
A new comer to Kernel Testing.


