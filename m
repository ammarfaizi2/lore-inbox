Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314404AbSD0TXE>; Sat, 27 Apr 2002 15:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314407AbSD0TXD>; Sat, 27 Apr 2002 15:23:03 -0400
Received: from pc3-camc5-0-cust13.cam.cable.ntl.com ([80.4.125.13]:64470 "EHLO
	fenrus.demon.nl") by vger.kernel.org with ESMTP id <S314404AbSD0TXD>;
	Sat, 27 Apr 2002 15:23:03 -0400
Date: Sat, 27 Apr 2002 20:19:58 +0100
Message-Id: <200204271919.g3RJJwk25487@fenrus.demon.nl>
From: arjan@fenrus.demon.nl
To: Matthew M <matthew.macleod@btinternet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Microcode update driver
In-Reply-To: <m171Yag-000Ga6C@Wasteland>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.9-31 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <m171Yag-000Ga6C@Wasteland> you wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Saturday 27 April 2002 7:57 pm, Roy Sigurd Karlsbakk wrote:
>> Sorry if this is a FAQ, but where's the microcode.dat supposed to be
>> placed? I can't find any information about that in the doc.
> 
> /usr/share/misc/microcode.dat

hum doesn't the FHS specify that /usr/share shouldn't contain arch
specific files ? microcode.dat I can't really call arch neutral....
