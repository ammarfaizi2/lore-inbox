Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262930AbSJAWxf>; Tue, 1 Oct 2002 18:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262936AbSJAWxf>; Tue, 1 Oct 2002 18:53:35 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.18.111]:5901 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262930AbSJAWxd>; Tue, 1 Oct 2002 18:53:33 -0400
Date: Wed, 2 Oct 2002 00:59:01 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Dominik Brodowski <linux@brodo.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, hpa@zytor.com, cpufreq@www.linux.org.uk
Subject: Re: cpufreq patches for 2.5.39 follow
Message-ID: <20021001225901.GC30488@atrey.karlin.mff.cuni.cz>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DEEA@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DEEA@orsmsx119.jf.intel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Support for mobile AMD K7 processors is still in development.
> > 
> > What about mobile celerons?
> 
> Mobile Celerons do not support voltage scaling.

But they can do frequency changes, right? And frequency is what
cpufreq is about, AFAICS. [I do not think k6 supports voltage scaling,
either. And ARM machines can't do voltage scaling, too.]
							Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
