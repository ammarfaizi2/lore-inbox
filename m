Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316786AbSFZTFy>; Wed, 26 Jun 2002 15:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316788AbSFZTFx>; Wed, 26 Jun 2002 15:05:53 -0400
Received: from jstevenson.plus.com ([212.159.71.212]:6695 "EHLO devil.stev.org")
	by vger.kernel.org with ESMTP id <S316786AbSFZTFw>;
	Wed, 26 Jun 2002 15:05:52 -0400
Message-ID: <008901c21d44$231e5fd0$0501a8c0@Stev.org>
From: "James Stevenson" <mistral@stev.org>
To: <gul@gul.kiev.ua>, <linux-kernel@vger.kernel.org>
References: <20020626110230.GA21100@happy.kiev.ua>
Subject: Re: kernel crash
Date: Wed, 26 Jun 2002 20:03:20 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> Jun 20 04:33:30 gate kernel: ------------[ cut here ]------------
> Jun 20 04:33:30 gate kernel: kernel BUG at inode.c:1066!
> Jun 20 04:33:30 gate kernel: invalid operand: 0000
> Jun 20 04:33:30 gate kernel: ip_nat_ftp ipt_REJECT ipt_REDIRECT cls_u32
sch_tbf sch_cbq autofs smbfs ne2k-p
> Jun 20 04:33:30 gate kernel: CPU:    0
> Jun 20 04:33:31 gate kernel: EIP:    0010:[iput+47/496]    Tainted: P
> Jun 20 04:33:31 gate kernel: EIP:    0010:[<c0148cdb>]    Tainted: P
> Jun 20 04:33:31 gate kernel: EFLAGS: 00010286

what makes your kernel tainted ?
do you have some binary only drivers ?




