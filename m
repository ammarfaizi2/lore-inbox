Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290209AbSAWXgL>; Wed, 23 Jan 2002 18:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290210AbSAWXgC>; Wed, 23 Jan 2002 18:36:02 -0500
Received: from mailgate.pit.comms.marconi.com ([169.144.68.6]:21499 "EHLO
	mailgate.pit.comms.marconi.com") by vger.kernel.org with ESMTP
	id <S290209AbSAWXfz>; Wed, 23 Jan 2002 18:35:55 -0500
Message-ID: <313680C9A886D511A06000204840E1CF40B60A@whq-msgusr-02.pit.comms.marconi.com>
From: "Punj, Arun" <Arun.Punj@marconi.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: NEWBIE : can't find /lib/modules/2.4.17/modules.dep error
Date: Wed, 23 Jan 2002 18:35:47 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Folks,

I upgraded the 2.4.7-10 kernel that comes with RH7.2 to 2.4.17. 
[ I could compile it fine and grub is able to load it too...]

However, I see the error : can't find /lib/modules/2.4.17/modules.dep
multiple times.

Afcourse there is no such file or directory. I suspect that this
directory and file should have been created when I compiled 2.4.17 
kernel but it did not. ( I did make bzImage )

Can you please point out the problem and also the effect of this
error because I cannot see any side effect of this error.

Thanks
Arun


This e-mail and any attachments are confidential. If you are not the
intended recipient, please notify us immediately by reply e-mail and then
delete this message from your system. Do not copy this e-mail or any
attachment, use the contents for any purposes, or disclose the contents to
any other person: to do so could be a breach of confidence.
