Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143431AbRELAgD>; Fri, 11 May 2001 20:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143433AbRELAfw>; Fri, 11 May 2001 20:35:52 -0400
Received: from h55p103-2.delphi.afb.lu.se ([130.235.187.175]:32995 "EHLO gin")
	by vger.kernel.org with ESMTP id <S143431AbRELAff>;
	Fri, 11 May 2001 20:35:35 -0400
Date: Sat, 12 May 2001 02:38:48 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: andersg@0x63.nu, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac8 now with added correct EXTRAVERSION
Message-ID: <20010512023848.B784@h55p111.delphi.afb.lu.se>
In-Reply-To: <20010512021351.A784@h55p111.delphi.afb.lu.se> <E14yNBC-0001sV-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <E14yNBC-0001sV-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, May 12, 2001 at 01:22:42AM +0100
From: andersg@0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 12, 2001 at 01:22:42AM +0100, Alan Cox wrote:
> > Somewhere between ac5 and ac8 ipc broke, noticed that fakeroot stopped
> > working, getting a function not implemented in msgget:
> > 
> > [pid  9812] msgget(667493921, IPC_CREAT|0x180|0600) = -1 ENOSYS (Function not implemented)
> 
> Looks you you compiled without SYS5 ipc support

yes, of course.. must have slipped on my keyboard while changing the
pcmcia-config. thanks!

-- 

//anders/g

