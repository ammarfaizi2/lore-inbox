Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310134AbSBRGEN>; Mon, 18 Feb 2002 01:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310135AbSBRGED>; Mon, 18 Feb 2002 01:04:03 -0500
Received: from angband.namesys.com ([212.16.7.85]:3712 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S310134AbSBRGDp>; Mon, 18 Feb 2002 01:03:45 -0500
Date: Mon, 18 Feb 2002 09:03:43 +0300
From: Oleg Drokin <green@namesys.com>
To: Sebastian =?koi8-r?Q?Dr=F6ge?= <sebastian.droege@gmx.de>
Cc: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: Reiserfs Corruption with 2.5.5-pre1
Message-ID: <20020218090343.B1186@namesys.com>
In-Reply-To: <20020214155716.3b810a91.sebastian.droege@gmx.de> <20020214180501.A1755@namesys.com> <20020214162232.5e59193b.sebastian.droege@gmx.de> <20020214172421.5d8ae63c.sebastian.droege@gmx.de> <20020214192633.A2311@namesys.com> <20020215135223.46af1b28.sebastian.droege@gmx.de> <20020215155413.A7974@namesys.com> <20020216162503.270ab9cc.sebastian.droege@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020216162503.270ab9cc.sebastian.droege@gmx.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Please show a process list when this happens (ps axlwww)

Bye,
    Oleg
On Sat, Feb 16, 2002 at 04:25:03PM +0100, Sebastian Dröge wrote:
> Hi,
> I've run gnome-terminal with strace and something interesting has happened...
> gnome-terminal hangs with an endless loop doing polls. strace output is attached. Maybe you can find the problem
> 
> Back to the files again... in 2.4.17 they aren't created... in 2.5.5-pre1 they are SOMETIMES created.
> In the moment I'm running 2.5.5-pre1 and no strange file is created
> gnome-terminal doesn't run. Every (?) other programm runs
> 
> Bye




