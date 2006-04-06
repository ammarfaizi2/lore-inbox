Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWDFNdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWDFNdX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 09:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWDFNdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 09:33:23 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:47373 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1751141AbWDFNdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 09:33:22 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>,
       "openbsd shen" <openbsd.shen@gmail.com>
Cc: "kernel" <linux-kernel@vger.kernel.org>
Subject: RE: What means "\xc7\x44\x24\x18\xda\xff\xff\xff\xe8"
Date: Thu, 6 Apr 2006 06:32:51 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKGEBCLDAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <Pine.LNX.4.61.0604060813380.8803@chaos.analogic.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Thu, 06 Apr 2006 06:29:04 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Thu, 06 Apr 2006 06:29:04 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> In what file did you find this? This is how back-doors are written!
> 
> On Wed, 5 Apr 2006, openbsd shen wrote:
> 
> > this code from get_sct() of suckit 2, why memmem()
> > "\xc7\x44\x24\x18\xda\xff\xff\xff\xe8"use, what it want to find?
> > The get_sct() founction:

	As he said, it's from "suckit 2", a root kit.

	Back-doors in a root kit? Whodathunkit. ;)

	DS


