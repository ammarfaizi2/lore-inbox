Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262062AbTCVI5t>; Sat, 22 Mar 2003 03:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262067AbTCVI5t>; Sat, 22 Mar 2003 03:57:49 -0500
Received: from MailBox.iNES.RO ([80.86.96.21]:37051 "EHLO MailBox.iNES.RO")
	by vger.kernel.org with ESMTP id <S262062AbTCVI5s>;
	Sat, 22 Mar 2003 03:57:48 -0500
Subject: Re: Ded-Fat 8.0 and ext3
From: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
To: root@chaos.analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0303211420170.13876@chaos>
References: <Pine.LNX.4.53.0303211420170.13876@chaos>
Content-Type: text/plain
Organization: iNES Advertising
Message-Id: <1048324118.3306.3.camel@LNX.iNES.RO>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 22 Mar 2003 11:08:39 +0200
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.4.1(snapshot 20020919) (MailBox.iNES.RO)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Vi, 2003-03-21 at 21:31, Richard B. Johnson wrote:
> Hello all. Greetings from fix-up land.
> 
> I installed RedHat 8.0 of an existing system.  By default it
> makes ext3 file-systems with journaling enabled.
> 
> That distribution used Linux-2.4.18-14.
> I copied /boot/config-2.4.18-14 to /usr/src/linux-2.4.18-15/.config
> as a ".config" file and executed:
> 
> `make oldconfig`
> 
[stuff deleted]

AFAIR, you must do an "make mrproper" before copying the config  and the
screenfull of errors will go away.


//Cioby


