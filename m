Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129111AbRCBM7s>; Fri, 2 Mar 2001 07:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129112AbRCBM7i>; Fri, 2 Mar 2001 07:59:38 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:45806 "HELO
	burns.conectiva") by vger.kernel.org with SMTP id <S129111AbRCBM70> convert rfc822-to-8bit;
	Fri, 2 Mar 2001 07:59:26 -0500
Date: Fri, 2 Mar 2001 11:01:45 -0300 (EST)
From: Fernando Fuganti <fuganti@conectiva.com.br>
To: Jakob Østergaard <jakob@unthought.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ZF MachZ Watchdog driver
In-Reply-To: <20010301233328.A11851@unthought.net>
Message-ID: <Pine.LNX.4.21.0103021053580.991-100000@ze.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Mar 2001, Jakob Østergaard wrote:

> I have a user-space daemon for driving the watchdog.  I see it uses the
> same user-space interface as sbc60xxwdt.c, except it can't be disabled :)
> 
> Did you write one too ?

a simple one (should be complex ?)

look at http://cvs.conectiva.com.br/drivers/ZFL-watchdog

 
> Should we find somewhere to actually publish these watchdog-daemons ?

ftp.kernel.org/pub/linux/daemons ?


Fernando Fuganti

