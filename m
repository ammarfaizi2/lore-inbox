Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313128AbSEHLrp>; Wed, 8 May 2002 07:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313131AbSEHLro>; Wed, 8 May 2002 07:47:44 -0400
Received: from ns.suse.de ([213.95.15.193]:32779 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313128AbSEHLrm>;
	Wed, 8 May 2002 07:47:42 -0400
Date: Wed, 8 May 2002 13:47:42 +0200
From: Dave Jones <davej@suse.de>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 57
Message-ID: <20020508134741.B17402@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Anton Altaparmakov <aia21@cantab.net>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5.1.0.14.2.20020507151627.02390bd0@pop.cus.cam.ac.uk> <5.1.0.14.2.20020507144123.022ae2f0@pop.cus.cam.ac.uk> <Pine.LNX.4.44.0205052046590.1405-100000@home.transmeta.com> <5.1.0.14.2.20020507140736.022aed90@pop.cus.cam.ac.uk> <3CD7C9F1.2000407@evision-ventures.com> <5.1.0.14.2.20020507144123.022ae2f0@pop.cus.cam.ac.uk> <20020507160825.S22215@suse.de> <5.1.0.14.2.20020507151627.02390bd0@pop.cus.cam.ac.uk> <20020507185151.A12134@suse.de> <5.1.0.14.2.20020508043035.028a7110@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2002 at 04:38:31AM +0100, Anton Altaparmakov wrote:
 > >http://www.codemonkey.org.uk/cruft/ide-info-0.0.5-dj.tar.gz
 > Ok, will get that. Someone else emailed me a url and I tried that earlier 
 > on (ages ago it seems) it said version 0.0.4

I don't think 0.0.5 actually hit the streets, I just named it that as
this one contained something or other I did (can't remember what exactly
diff will tell you) that I was intended to send to the author for 0.0.5
 
 > Certainly it bears no resemblance to what /proc/ide/via
 > has to say and it certainly bears no resemblance to 
 > reality... )-:

Likely it needs an update for the newer VIA chipsets, as this code is
~2 years old.  What it does do however, is proove that this doesn't need
to be done in kernel space.

    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
