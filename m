Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316824AbSHOMFu>; Thu, 15 Aug 2002 08:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316822AbSHOMFu>; Thu, 15 Aug 2002 08:05:50 -0400
Received: from [210.78.134.243] ([210.78.134.243]:51211 "EHLO 210.78.134.243")
	by vger.kernel.org with ESMTP id <S316821AbSHOMFu>;
	Thu, 15 Aug 2002 08:05:50 -0400
Date: Thu, 15 Aug 2002 20:12:7 +0800
From: zhengchuanbo <zhengcb@netpower.com.cn>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: problem with Adaptec aic7899 in linux2.4
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Message-Id: <200208152016307.SM00808@zhengcb>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i met a problem with the scsi disk on linux2.4.19-pre1.
during the boot of the system,the following messages were displayed,

(scsi:A:15:0): Unexpected busfree while idle
scsi: <fdomain> Detection failed (no card)
sys53c416.c: Version 1.0.0-ac

then the system hang the. we use adaptec aic7899. 
btw,the same system worked on another machine with the same type of scsi disk.
so what's the problem?
please cc.thanks.

zhengchuanbo
zhengcb@netpower.com.cn

