Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288441AbSATMiN>; Sun, 20 Jan 2002 07:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288473AbSATMiD>; Sun, 20 Jan 2002 07:38:03 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:43243 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S288441AbSATMhw>;
	Sun, 20 Jan 2002 07:37:52 -0500
Date: Sun, 20 Jan 2002 13:37:45 +0100
From: David Weinehall <tao@acc.umu.se>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Guillaume Boissiere <boissiere@mediaone.net>, linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  January 18, 2002
Message-ID: <20020120133745.C1735@khan.acc.umu.se>
In-Reply-To: <3C477B7F.22875.11D4078A@localhost> <m1zo39grhm.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m1zo39grhm.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sun, Jan 20, 2002 at 05:02:29AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2002 at 05:02:29AM -0700, Eric W. Biederman wrote:
> "Guillaume Boissiere" <boissiere@mediaone.net> writes:
> 
> > Here is a new and improved list, thanks to all the great feedback I have 
> > received from dozens of people.  Again, if there are any inaccuracies,
> > please let me know and I will do my best to correct it for next week.
> > 
> > For everyone's enjoyment, I have also put an online version, (with 
> > hyperlinks, yeah!) at:
> > http://people.ne.mediaone.net/boissiere/Status-18-Jan-2002.html 
> > 
> > Items in bold are new since last time.  Also, to avoid having the list
> > become too big over time, I have decided that I will only accept items 
> > that can be expected to be merged within the next 6 months (i.e. the 
> > end of June).
> 
> >From the linuxBIOS project:
> Linux booting elf images (aka linux)
>    The core is stable and I'm working out some last details of the interface.
> 
> First pass at LinuxBIOS support 
>    I have code it just needs to fit into the kernel tree.

Unless it's already in there:

* Sort out which USB UHCI-driver to keep (UHCI or UHCI-JE)


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
