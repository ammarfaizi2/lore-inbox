Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbVEZAqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVEZAqc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 20:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVEZAqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 20:46:32 -0400
Received: from pop.gmx.de ([213.165.64.20]:3781 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261627AbVEZAqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 20:46:31 -0400
X-Authenticated: #14640924
Message-ID: <012e01c5618d$39d328b0$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
To: <linux-kernel@vger.kernel.org>
Subject: cowloop - copy-on-write loop driver
Date: Thu, 26 May 2005 02:52:42 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !
just want to inform that here is a cool new loopback driver variant at: http://www.atconsultancy.nl/cowloop/

"The cowloop driver is a copy-on-write loop driver (block device) to be used on top of any other block driver. The cowloop driver
shields the lower driver from any write accesses. Instead, it diverts all write-accesses to an arbitrary regular file."

regards
Roland
ps:
I`m not directly involved in development - i just came across that site some time ago and thought it was worth being mentioned here.
(didn`t find a reference in the ML archive)

