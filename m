Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261937AbTCLUcG>; Wed, 12 Mar 2003 15:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261941AbTCLUcG>; Wed, 12 Mar 2003 15:32:06 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:49351
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261937AbTCLUcE>; Wed, 12 Mar 2003 15:32:04 -0500
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Dana Lacoste <dana.lacoste@peregrine.com>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0303121801580.32518-100000@serv>
References: <20030312034330.GA9324@work.bitmover.com>
	 <20030312041621.GE563@phunnypharm.org> <20030312085517.GK811@suse.de>
	 <20030312032614.G12806@schatzie.adilger.int>
	 <b4nmau$3d0$1@cesium.transmeta.com>
	 <1047486659.16704.161.camel@dlacoste.ottawa.loran.com>
	 <Pine.LNX.4.44.0303121801580.32518-100000@serv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047505841.23725.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 12 Mar 2003 21:50:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-12 at 17:08, Roman Zippel wrote:
> this was one of the conditions for the bk usage, so Larry cannot say, that 
> you only get all the data if you use bk. If cvs can't represent all the 
> information, we have to find another solution.

CVS can't represent it all because CVS isnt up to the job. If the rest
exists as comments then its your problem to write a VCS that can extract
the comment data and represent it in full

