Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265130AbTAWL3v>; Thu, 23 Jan 2003 06:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265134AbTAWL3v>; Thu, 23 Jan 2003 06:29:51 -0500
Received: from mailbox.gdufs.edu.cn ([202.116.192.38]:15003 "EHLO
	mailsvr.gdufs.edu.cn") by vger.kernel.org with ESMTP
	id <S265130AbTAWL3u>; Thu, 23 Jan 2003 06:29:50 -0500
Message-ID: <002201c2c2d4$612c8c80$81df74ca@hammer>
From: "Yao Minfeng" <yaomf@gdufs.edu.cn>
To: "Ketil Froyn" <kernel@ketil.froyn.name>
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0301231225040.13736-100000@lexx.infeline.org>
Subject: Re: new kernel fail
Date: Thu, 23 Jan 2003 19:41:13 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks a lot, Ketil,

I am using ext3 for 2.4.7-10, but during the kernel configuration, I can't
find the option to include ext3, any suggestions?

Yao



> On Thu, 23 Jan 2003, Yao Minfeng wrote:
>
> > 2) all the files under /home, /usr are missing, this happens both for
2.4.12
> > and 2.4.16, but when I login back to 2.4.7-10, the files are there
again, I
> > can't figure it out.
>
> Perhaps you forgot to include the filesystem these are using in your
> kernel...?
>
> Ketil
>
>
>

