Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267880AbTBVLPq>; Sat, 22 Feb 2003 06:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267881AbTBVLPq>; Sat, 22 Feb 2003 06:15:46 -0500
Received: from ce06d.unt0.torres.ka0.zugschlus.de ([212.126.206.6]:31493 "EHLO
	torres.ka0.zugschlus.de") by vger.kernel.org with ESMTP
	id <S267880AbTBVLPp>; Sat, 22 Feb 2003 06:15:45 -0500
Date: Sat, 22 Feb 2003 12:25:53 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ethernet-ATM-Router freezing
Message-ID: <20030222112553.GB24580@torres.ka0.zugschlus.de>
References: <20030222084958.GC23827@torres.ka0.zugschlus.de> <20030222113416.A14834@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030222113416.A14834@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2003 at 11:34:16AM +0100, romieu@fr.zoreil.com wrote:
> Marc Haber <mh+linux-kernel@zugschlus.de> :
> [...]
> > I am currently thinking about splitting the load between both boxes,
> > and downgrading one of them to a 2.4.19 or 2.4.18 kernel, and
> > upgrading the other one to a 2.4.21pre kernel. Have there been any
> > relevant changes to the ATM code recently?
> 
> - what kind of hardware adapter do you have ?

00:0f.0 ATM network controller: FORE Systems Inc PCA-200E
        Flags: bus master, medium devsel, latency 64, IRQ 9
        Memory at efa00000 (32-bit, non-prefetchable) [size=2M]
        Expansion ROM at effe0000 [disabled] [size=8K]

> - does the problem disappear with 2.4.20 ?

I will downgrade one of the boxes to 2.4.20 later today. This is going
to be a busy weekend anyway :-(

Greetings
Marc


-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Karlsruhe, Germany |  lose things."    Winona Ryder | Fon: *49 721 966 32 15
Nordisch by Nature |  How to make an American Quilt | Fax: *49 721 966 31 29
