Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264844AbTB0Ma7>; Thu, 27 Feb 2003 07:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264867AbTB0Ma7>; Thu, 27 Feb 2003 07:30:59 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:43279 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S264844AbTB0Ma6>; Thu, 27 Feb 2003 07:30:58 -0500
Date: Thu, 27 Feb 2003 07:40:02 -0500
From: Ben Collins <bcollins@debian.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, ajoshi@kernel.crashing.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre5
Message-ID: <20030227124002.GA21100@phunnypharm.org>
References: <Pine.LNX.4.53L.0302270314050.1433@freak.distro.conectiva> <20030227083238.GS7685@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030227083238.GS7685@fs.tum.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2003 at 09:32:39AM +0100, Adrian Bunk wrote:
> On Thu, Feb 27, 2003 at 03:14:44AM -0300, Marcelo Tosatti wrote:
> > 
> > So here goes -pre5.
> > 
> > 
> > Summary of changes from v2.4.21-pre4 to v2.4.21-pre5
> > ============================================
> > 
> > <ajoshi@kernel.crashing.org>:
> >   o rivafb 0.9.4 update
> >...
> 
> WTF is this???
> 
> Besides the rivafb update it reverts parts of the IEEE 1394 patches that 
> were included in -pre4.

Yes, please revert this, and then make sure _my_ patch gets into -pre6?

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
