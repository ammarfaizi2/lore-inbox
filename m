Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267878AbTBVUYg>; Sat, 22 Feb 2003 15:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267901AbTBVUYg>; Sat, 22 Feb 2003 15:24:36 -0500
Received: from ce06d.unt0.torres.ka0.zugschlus.de ([212.126.206.6]:55561 "EHLO
	torres.ka0.zugschlus.de") by vger.kernel.org with ESMTP
	id <S267878AbTBVUYf>; Sat, 22 Feb 2003 15:24:35 -0500
Date: Sat, 22 Feb 2003 21:34:44 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-ac1 not seeing IDE disk on PIIX host adapter
Message-ID: <20030222203443.GA27734@torres.ka0.zugschlus.de>
References: <20030222085102.GA23966@torres.ka0.zugschlus.de> <1045946551.5484.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045946551.5484.2.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2003 at 08:42:31PM +0000, Alan Cox wrote:
> On Sat, 2003-02-22 at 08:51, Marc Haber wrote:
> > Linux 2.4.20-ac1 sees the PIIX chip, but not the disks connected to
> > it. This of course results in a kernel panic "unable to mount root
> > fs". Same thing happens with 2.4.20-ac2. Vanilla 2.4.20 works fine. Of
> > course, all kernels have been built with the same configuration.
> 
> I'd like to know if 2.4.21pre4-ac6 sees the disks. You don't even need
> to run it beyond the boot, just to check this is the legacy port
> problem.

It will be monday before I get near the machine, but I will do it then.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Karlsruhe, Germany |  lose things."    Winona Ryder | Fon: *49 721 966 32 15
Nordisch by Nature |  How to make an American Quilt | Fax: *49 721 966 31 29
