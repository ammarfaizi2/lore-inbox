Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbTICOmX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 10:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbTICOlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 10:41:47 -0400
Received: from mail02.powweb.com ([63.251.216.35]:58634 "EHLO
	mail02.powweb.com") by vger.kernel.org with ESMTP id S263777AbTICOkZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 10:40:25 -0400
Message-ID: <001f01c37229$4bbd0410$1400a8c0@gaussian>
From: "Stevo" <stevo@cool3dz.com>
To: <linux-kernel@vger.kernel.org>
Cc: <shampton@tsiconnections.com>
Subject: (Simple) Basic Design Flaw in make menuconfig GUI
Date: Wed, 3 Sep 2003 10:40:17 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, and thanks to all for continued support and developement of the Linux
kernel.  :)

APPLICATION: This applies to all kernels, all distributions, and all
architectures...


DESRIPTION: "make menuconfig"  GUI issue

SETUP: When I run "make menuconfig" and I am in the process of
enabling/disabling options, I have a "bad habit?" (that I'm sure is more
like an epidemic) of placing one finger on the "Esc" key, one finger on the
"Space" key, and another on the "Enter" key as I manuver through the various
selections.

PROBLEM: (ocassionally) While I am speeding through the kernel
configuration, I will accidentally hit the "Esc" key one too many times (I'm
sure we've all done this) and it will leave me at the "exit" screen:

                        Do you wish to save your new kernel config?

                                           <Yes>     <No>

In this case, neither choice is acceptable. In a plea to save time for all,
can someone please add one more simple choice to the "exit" menu?

                        Do you wish to save your new kernel config?

                             <Yes>     <No>     <Return to Config>



Thanks for your time, and thanks once again for all who continually work
towards the advancement of Linux.


Regards,
Steve Hampton

