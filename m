Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293719AbSCAEfj>; Thu, 28 Feb 2002 23:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310299AbSCAEdv>; Thu, 28 Feb 2002 23:33:51 -0500
Received: from a1as14-p178.stg.tli.de ([195.252.191.178]:44769 "EHLO
	dea.linux-mips.net") by vger.kernel.org with ESMTP
	id <S310348AbSCAEdU>; Thu, 28 Feb 2002 23:33:20 -0500
Date: Fri, 1 Mar 2002 05:32:38 +0100
From: Ralf Baechle <ralf@conectiva.com.br>
To: Dax Kelson <dax@gurulabs.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre2 on Cobalt Qube 2?
Message-ID: <20020301053238.A32004@dea.linux-mips.net>
In-Reply-To: <Pine.LNX.4.21.0202281742250.2182-100000@freak.distro.conectiva> <Pine.LNX.4.44.0202282112130.14732-100000@mooru.gurulabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0202282112130.14732-100000@mooru.gurulabs.com>; from dax@gurulabs.com on Thu, Feb 28, 2002 at 09:18:30PM -0700
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2002 at 09:18:30PM -0700, Dax Kelson wrote:

> > Here is 2.4.19-pre2: A very big patch (around 13MB uncompressed) due to
> > the architecture (MIPS and IA64 mainly) updates. 
> 
> Does this MIPS merge mean that the 2.4.19-pre2 kernel would work on a MIPS
> based Cobalt Qube 2? It that's the case, then I just need a working 
> userland.
> 
> The official Linux kernel from Cobalt is 2.0 vintage. I'm currently
> running NetBSD 1.5.2 to have something a little more modern, but I would 
> like to come back to Linux if possible.

The MIPS merge still isn't complete, this was just the bulk part.  So such
I haven't even tried to build let alone test Marcelo's -pre2 kernel.  If
you want a 2.4.18 kernel for a Qube, get it via anonymous CVS.  See the
MIPS HOWTO at http://oss.sgi.com/mips/mips-howto.html.

  Ralf

--
"Embrace, Enhance, Eliminate" - it worked for the pope, it'll work for Bill.
