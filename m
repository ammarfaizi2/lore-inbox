Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266069AbTB0TRL>; Thu, 27 Feb 2003 14:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266257AbTB0TRL>; Thu, 27 Feb 2003 14:17:11 -0500
Received: from gate.crashing.org ([63.228.1.57]:41906 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id <S266069AbTB0TRK>;
	Thu, 27 Feb 2003 14:17:10 -0500
Date: Thu, 27 Feb 2003 13:22:25 -0600 (CST)
From: ajoshi@kernel.crashing.org
To: Ben Collins <bcollins@debian.org>
cc: Adrian Bunk <bunk@fs.tum.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, trond.myklebust@fys.uio.no
Subject: Re: Linux 2.4.21-pre5
In-Reply-To: <20030227124002.GA21100@phunnypharm.org>
Message-ID: <Pine.LNX.4.10.10302271321001.2477-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Just for the record, the patch I sent to Marcelo did _NOT_ include any
1394 hunks in it.  Marcelo must have accidently mixed mine up with some
old 1394 tree.


ani

On Thu, 27 Feb 2003, Ben Collins wrote:

> On Thu, Feb 27, 2003 at 09:32:39AM +0100, Adrian Bunk wrote:
> > On Thu, Feb 27, 2003 at 03:14:44AM -0300, Marcelo Tosatti wrote:
> > > 
> > > So here goes -pre5.
> > > 
> > > 
> > > Summary of changes from v2.4.21-pre4 to v2.4.21-pre5
> > > ============================================
> > > 
> > > <ajoshi@kernel.crashing.org>:
> > >   o rivafb 0.9.4 update
> > >...
> > 
> > WTF is this???
> > 
> > Besides the rivafb update it reverts parts of the IEEE 1394 patches that 
> > were included in -pre4.
> 
> Yes, please revert this, and then make sure _my_ patch gets into -pre6?
> 
> -- 
> Debian     - http://www.debian.org/
> Linux 1394 - http://www.linux1394.org/
> Subversion - http://subversion.tigris.org/
> Deqo       - http://www.deqo.com/
> 


