Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289795AbSBKOap>; Mon, 11 Feb 2002 09:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289802AbSBKOaO>; Mon, 11 Feb 2002 09:30:14 -0500
Received: from angband.namesys.com ([212.16.7.85]:22912 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S289803AbSBKO1x>; Mon, 11 Feb 2002 09:27:53 -0500
Date: Mon, 11 Feb 2002 17:27:47 +0300
From: Oleg Drokin <green@namesys.com>
To: Luigi Genoni <kernel@Expansa.sns.it>
Cc: Alex Riesen <fork0@users.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-dev] 2.5.4-pre1: zero-filled files reiserfs
Message-ID: <20020211172747.A1815@namesys.com>
In-Reply-To: <20020211160948.B7863@namesys.com> <Pine.LNX.4.44.0202111522130.2643-100000@Expansa.sns.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0202111522130.2643-100000@Expansa.sns.it>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Feb 11, 2002 at 03:23:51PM +0100, Luigi Genoni wrote:

> > .history may be corrupted if your partition was not unmounted properly
> > before reboot.
> other files corrupted were
> /etc/rc.d/rc.local /etc/rc.d/rc.inet2
> /etc/lilo.conf on the PIII
> /scratch/root/<some .c source file> on the Athlon
> / partition is not the same of /home.
All of this on 2.5.4-pre1 only?
Or were you able to reproduce it on later kernels too?

Bye,
    Oleg
