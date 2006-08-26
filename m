Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422713AbWHZRPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422713AbWHZRPX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 13:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422879AbWHZRPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 13:15:23 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:48842 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1422713AbWHZRPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 13:15:22 -0400
Reply-To: <techweb@ntlworld.com>
From: "Stephen Elliott" <techweb@ntlworld.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4 Kernel APIC Issues
Date: Sat, 26 Aug 2006 18:15:27 +0100
Message-ID: <IIEJIKFPPDCDIOOHEDKIEELMCCAA.techweb@ntlworld.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recently upgraded from 2.4.20 to 2.4.32 and everything seemed fine.
However, on the console I see messages like "APIC Error on CPU0" and
"Spurious Intrerrupt IRQ7".

I am using an MSI K7N420 Pro and it has an nforce chipset. I am aware that
there have been a number of issues reported regarding this issue and was
wondering if a patch is available and if not will there be one in the
future. I don't particually want to upgrade to the 2.6 kernel at this time.

Many Thanks
Stephen Elliott
--
No virus found in this outgoing message.
Checked by AVG Free Edition.
Version: 7.1.405 / Virus Database: 268.11.6/428 - Release Date: 25/08/2006

