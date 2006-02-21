Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161049AbWBUOCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161049AbWBUOCD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 09:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161058AbWBUOCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 09:02:03 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:37032 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S1161049AbWBUOCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 09:02:01 -0500
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI \_sb_
In-Reply-To: <Pine.LNX.4.61.0602201850120.24598@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0602201850120.24598@yvahk01.tjqt.qr>
Date: Tue, 21 Feb 2006 14:02:01 +0000
Message-Id: <E1FBY5Z-0002la-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> does anyone know what the SB in \_SB_.PCI0._PRT means?

"System bustree" - stuff that's connected to the system bus, basically.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
