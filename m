Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286184AbRLJTmg>; Mon, 10 Dec 2001 14:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286360AbRLJTm1>; Mon, 10 Dec 2001 14:42:27 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:6667 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S286184AbRLJTmL>; Mon, 10 Dec 2001 14:42:11 -0500
Date: Mon, 10 Dec 2001 20:41:57 +0100
From: Jurriaan on Alpha <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: Compile error 2.4.1-pre8
Message-ID: <20011210194157.GA2220@alpha.of.nowhere>
Reply-To: thunder7@xs4all.nl
In-Reply-To: <20011210131425.A24397@rene-engelhard.de> <20011210133558.A24786@rene-engelhard.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011210133558.A24786@rene-engelhard.de>
User-Agent: Mutt/1.3.24i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2001 at 01:35:58PM +0100, Rene Engelhard wrote:
> Rene Engelhard wrote:
> > I'm gonna want to start with helping developing the kernel and I have
> > the following compile error at make bzImage from 2.5.1-pre8:
> 
> Sorry, I forgot my .config.
> 
I don't know anything about your error, but could you please run
egrep "=m$|=y$" on your .config before posting? We all know what
comments are in a .config, and they are not interesting!

Thanks,
Jurriaan
-- 
hundred-and-one symptoms of being an internet addict:
256. You are able to write down over 250 symptoms of being an internet
addict, even though they only asked for 101.
GNU/Linux 2.4.17-pre7 on Debian/Alpha 64-bits 992 bogomips load:0.59 0.29 0.13
