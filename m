Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbRBAAoO>; Wed, 31 Jan 2001 19:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129102AbRBAAoE>; Wed, 31 Jan 2001 19:44:04 -0500
Received: from shell.chaven.com ([207.238.162.18]:37031 "EHLO shell.chaven.com")
	by vger.kernel.org with ESMTP id <S129055AbRBAAny>;
	Wed, 31 Jan 2001 19:43:54 -0500
Message-ID: <033201c08be7$d8e22760$160912ac@stcostlnds2zxj>
From: "List User" <lists@chaven.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <3A78AFAF.82FCB4F2@Hell.WH8.TU-Dresden.De>
Subject: Any reason why we can't auto-start LVM (vg's) in the kernel?
Date: Wed, 31 Jan 2001 18:42:20 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any reason why we can't auto-detect/bring up volume-groups in the
kernel instead of creating a ramdisk volume to do a vgscan and then mount a
rootlv?

Just trying to see if there is a way (or would make sense) to skip the
ramdisk stage in mounting a root logical volume.

Steve

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
