Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276312AbRKSO1m>; Mon, 19 Nov 2001 09:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278163AbRKSO1c>; Mon, 19 Nov 2001 09:27:32 -0500
Received: from jakorasia.nic.fi ([212.38.224.80]:57804 "EHLO jakorasia.nic.fi")
	by vger.kernel.org with ESMTP id <S276312AbRKSO1U>;
	Mon, 19 Nov 2001 09:27:20 -0500
Message-Id: <200111191427.QAA11984@jakorasia.nic.fi>
Content-Type: text/plain; charset=US-ASCII
From: jarmo kettunen <oh1mrr@nic.fi>
To: linux-kernel@vger.kernel.org
Subject: Module 6pack
Date: Mon, 19 Nov 2001 16:27:24 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I don't know if this have been cleared before,anyway can't find any help.
In module 6pack is something weird...when I try close computer or reboot
it,I get just at the end of closing process message:
unregister_detdevice:waiting for sp0 to become free.Usage count=1654.
Number is growing what longer I'm using Hamradio stuff and computer stops 
there continuing sending that message.
I remember this message started at the end of 2.3.x series kernels,so I 
figured that something was done in kernel,module it self have been same???

I have posted this "bug" to author,but response was,that it takes long time
to check it out because of free time.

So question is purposed to ham-oriented coders,who might have some spare time
to look into code /linux/drivers/net/hamradio/6pack.c.Unfotunately I have NO 
skills with code.

I need to upgrade kernel into one comp,which I admin remote and now,if I have
remotely boot computer it hangs there,waiting for sp0 to become free...Needs 
to push button and that is remotely quite job..Distance cap 15km.

We have at the moment in use kernel 2.2.17 and there 6pack works...Module
version is 0.4.2...Here 2.4.15-pre5 it is 0.3.0?And NO...0.4.2 does not work
with this kernel.

So anybody intrested????

Jarmo
