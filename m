Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263741AbTDDPAn (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 10:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263745AbTDDO7w (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 09:59:52 -0500
Received: from mail.explainerdc.com ([212.72.36.220]:47015 "EHLO
	mail.explainerdc.com") by vger.kernel.org with ESMTP
	id S263742AbTDDO41 convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 09:56:27 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Promise TX4 100: neither IDE port enabled
Date: Fri, 4 Apr 2003 17:07:54 +0200
Message-ID: <73300040777B0F44B8CE29C87A0782E101FA98E9@exchange.explainerdc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Promise TX4 100: neither IDE port enabled
Thread-Index: AcL6p09KYT2Y3OMwRTyl/6R6pZ/ZXwAE5nZg
From: "Jonathan Vardy" <jonathan@explainerdc.com>
To: "Adam Johansson" <adam.johansson@madsci.se>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Without knowing the cause or fix for it I instead run ac-patches.
> The card(s) are than configured correctly.
> I now run 2.4.21pre5ac3 and I remember 2.4.21pre4ac4 also worked fine.

I tried 2.4.21-pre5-ac3 but still I get the same problems, with what
settings did you compile the kernel?

I used these:

On:  PROMISE PDC202{46|62|65|67} support
On:  Special UDMA Feature
On:  PROMISE PDC202{68|69|70|71|75|76|77} support

Off: Special FastTrak Feature
Off: Support for IDE Raid controllers (EXPERIMENTAL)

Yours sincerey, Jonathan Vardy
