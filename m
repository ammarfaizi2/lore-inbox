Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317299AbSFCHgb>; Mon, 3 Jun 2002 03:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317300AbSFCHgb>; Mon, 3 Jun 2002 03:36:31 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:13476 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317299AbSFCHg3>; Mon, 3 Jun 2002 03:36:29 -0400
Date: Mon, 3 Jun 2002 09:08:13 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Jeff Jenkins <jefreyr@pacbell.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Newbie SMP question
In-Reply-To: <3CFB0CFE.8040501@pacbell.net>
Message-ID: <Pine.LNX.4.44.0206030907390.10836-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jun 2002, Jeff Jenkins wrote:

> I am familiar with a command on Solaris, namely "psrinfo".  This 
> dispalys that # of CPUs on a box + additional info.  Is there a similar 
> command on Linux that will display the # of CPUs on a system and any 
> info about the CPUs ( make/model/etc.)?

`cat /proc/cpuinfo` should give you the required information.

Regards,
	Zwane Mwaikambo

-- 
http://function.linuxpower.ca
		

