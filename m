Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293595AbSCFOau>; Wed, 6 Mar 2002 09:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293597AbSCFOak>; Wed, 6 Mar 2002 09:30:40 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:17930 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S293595AbSCFOaU>; Wed, 6 Mar 2002 09:30:20 -0500
Date: Wed, 6 Mar 2002 15:30:03 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@zip.com.au>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Petition Against Official Endorsement of BitKeeper by Linux  
 Maintainers
In-Reply-To: <Pine.GSO.4.21.0203061424190.14695-100000@vervain.sonytel.be>
Message-ID: <Pine.LNX.4.21.0203061525160.6899-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 6 Mar 2002, Geert Uytterhoeven wrote:

> > I also prefer not to use Bitkeeper as long as possible for similar reasons 
> > and because it is too slow and clumpsy 
> > (although it is already very hard because often source is only available 
> > through it, e.g. for ppc or for 2.5 pre patches now -- hopefully this trend
> > does not continue)
> 
> The PPC trees are available through rsync as well.
> 
>     http://www.penguinppc.org/dev/kernel.shtml

With rsync you get only the latest version, but not any previous
version. For APUS I have to use bk to extract the ppc tree version I want
to import, for m68k I only have to go to ftp.kernel.org and grab the right
patch.

bye, Roman

