Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272818AbRJPGHe>; Tue, 16 Oct 2001 02:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272737AbRJPGHZ>; Tue, 16 Oct 2001 02:07:25 -0400
Received: from [67.104.35.198] ([67.104.35.198]:36482 "EHLO
	sparrow.websense.net") by vger.kernel.org with ESMTP
	id <S272636AbRJPGHK>; Tue, 16 Oct 2001 02:07:10 -0400
Date: Tue, 16 Oct 2001 02:06:26 -0400 (EDT)
From: William Stearns <wstearns@pobox.com>
X-X-Sender: <wstearns@sparrow.websense.net>
Reply-To: William Stearns <wstearns@pobox.com>
To: Juraj Buliscak <buliscakj@eurotel.sk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: how to compile old kernel
In-Reply-To: <OF6767106E.A15BB9B6-ONC1256AE7.001F1FD3@eurotel.sk>
Message-ID: <Pine.LNX.4.33.0110160203370.2929-100000@sparrow.websense.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day, Juraj,

On Tue, 16 Oct 2001, Juraj Buliscak wrote:

> I have RH 70 with original kernel 2.2.16-19.  Later I have compiled newer
> kernel 2.4.10 but it contains bugs in AX25 support, and therefore I decided
> to use old version of kernel 2.2.19, but it didn´t have been compiled it
> with AX25 support, so I need to do it.  If I try to compile kernel 2.2.19
> with kernel 2.4.10 actually running, it's not possible. MAKE gives me some
> errors.

	What errors?

> Please let me know how to compile old kernel.

rpm -Uvh ftp://ftp.stearns.org/pub/wstearns/buildkernel/buildkernel-1.05-1.noarch.rpm<Enter>
buildkernel 2.2.19 --BKOPENFRESH=YES<Enter>

	Buildkernel will lead you through the process.
	Cheers,
	- Bill

---------------------------------------------------------------------------
	Backscatter on net
	Spoofed IP could decoy
	From the DMZ
	-- Andrew MacPherson and Dan Burroughs
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, named2hosts,
and ipfwadm2ipchains are at:                http://www.pobox.com/~wstearns
LinuxMonth; articles for Linux Enthusiasts! http://www.linuxmonth.com
--------------------------------------------------------------------------

