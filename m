Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbWCYP2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbWCYP2I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 10:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWCYP2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 10:28:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:59340 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751428AbWCYP2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 10:28:06 -0500
X-Authenticated: #9400009
From: Hinrich Aue <h_aue@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: promise tx2plus SATA controller and ATAPI
Date: Sat, 25 Mar 2006 16:41:39 +0100
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603251641.39064.h_aue@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello there,

I purchased a promise TX2Plus SATA controller.
Works fine so far, but I also bought a SATA DVD writer.
The TX2Plus supports SATA ATAPI, and recognizes my burner correctly.
But in the boot messages it says:

ata2(0): WARNING: ATAPI is not supported with this driver, device ignored.

Is there a way to use the burner with this controller?
If not, are there plans to enable ATAPI for the sata_promise driver?

Thanks in advance,
	Hinrich
