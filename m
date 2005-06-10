Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVFJSnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVFJSnT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 14:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbVFJSnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 14:43:19 -0400
Received: from mail.inter-page.com ([207.42.84.180]:15116 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S261167AbVFJSnP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 14:43:15 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "'Jeff Garzik'" <jgarzik@pobox.com>
Cc: "'Kumar Gala'" <kumar.gala@freescale.com>,
       "'Linux Kernel list'" <linux-kernel@vger.kernel.org>
Subject: RE: stupid SATA questions
Date: Fri, 10 Jun 2005 11:51:26 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAujDVGqnqiEuiX8MD6j5uVwEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <42A72E4F.4040700@pobox.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Howdy,

I cannot find the ATA passthru or SMART option in the 2.6.11.10 kernel anywhere near
the SCSI or ATA .  Is it somewhere obscure, has it been renamed, or am I looking in
totally the wrong place? (e.g. is this an option when building hdparm or something?)

Rob.

-----Original Message-----
From: Jeff Garzik [mailto:jgarzik@pobox.com] 
Sent: Wednesday, June 08, 2005 10:44 AM

You need "ATA passthru" (SMART support) in order for hdparm to work.


