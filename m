Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310274AbSCBCTY>; Fri, 1 Mar 2002 21:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310275AbSCBCTO>; Fri, 1 Mar 2002 21:19:14 -0500
Received: from ns1.system-techniques.com ([199.33.245.254]:930 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S310274AbSCBCTD>; Fri, 1 Mar 2002 21:19:03 -0500
Date: Fri, 1 Mar 2002 21:18:15 -0500 (EST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Ralf Baechle <ralf@conectiva.com.br>
cc: Dax Kelson <dax@gurulabs.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre2 on Cobalt Qube 2?
In-Reply-To: <20020301053238.A32004@dea.linux-mips.net>
Message-ID: <Pine.LNX.4.44.0203012112130.32458-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Ralf ,  Where in the FAQ does it describe how to get from
	CVS the necessary components for a MIPsel kernel from CVS or do
	you just grab the whole kernel ?  Also the URL:
	ftp://intel.cleveland.lug.net/pub/Mipsel
	appears to not allow anon access anylonger .  Tia ,  JimL

ie:
$ ncftp ftp://intel.cleveland.lug.net/pub/Mipsel
NcFTP 3.0.2 (October 19, 2000) by Mike Gleason (ncftp@ncftp.com).
Connecting to 207.166.193.105...
ProFTPD 1.2.1 Server (ProFTPD Default Installation) [cleveland.lug.net]
Login incorrect.


On Fri, 1 Mar 2002, Ralf Baechle wrote:
> On Thu, Feb 28, 2002 at 09:18:30PM -0700, Dax Kelson wrote:
> > > Here is 2.4.19-pre2: A very big patch (around 13MB uncompressed) due to
> > > the architecture (MIPS and IA64 mainly) updates.
> > Does this MIPS merge mean that the 2.4.19-pre2 kernel would work on a MIPS
> > based Cobalt Qube 2? It that's the case, then I just need a working
> > userland.
> > The official Linux kernel from Cobalt is 2.0 vintage. I'm currently
> > running NetBSD 1.5.2 to have something a little more modern, but I would
> > like to come back to Linux if possible.
> The MIPS merge still isn't complete, this was just the bulk part.  So such
> I haven't even tried to build let alone test Marcelo's -pre2 kernel.  If
> you want a 2.4.18 kernel for a Qube, get it via anonymous CVS.  See the
> MIPS HOWTO at http://oss.sgi.com/mips/mips-howto.html.
>   Ralf

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

