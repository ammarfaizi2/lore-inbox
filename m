Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129965AbRAPQvU>; Tue, 16 Jan 2001 11:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130093AbRAPQvL>; Tue, 16 Jan 2001 11:51:11 -0500
Received: from mail2.megatrends.com ([155.229.80.11]:30736 "EHLO
	mail2.megatrends.com") by vger.kernel.org with ESMTP
	id <S130011AbRAPQvE>; Tue, 16 Jan 2001 11:51:04 -0500
Message-ID: <1355693A51C0D211B55A00105ACCFE64E95192@ATL_MS1>
From: Venkatesh Ramamurthy <Venkateshr@ami.com>
To: "'Matthias Andree'" <matthias.andree@gmx.de>,
        "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Linux not adhering to BIOS Drive boot order?
Date: Tue, 16 Jan 2001 11:46:43 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Is someone handling this already? 
> 
> "mount by uuid"?
> 
> Amiga's Rigid Disk Block?
	[Venkatesh Ramamurthy]  Something like this is better. The problem
is where do we store this info. Last sector is one of the options. Does
anyone know where NT stores this info?



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
