Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312681AbSEDMmE>; Sat, 4 May 2002 08:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312691AbSEDMmE>; Sat, 4 May 2002 08:42:04 -0400
Received: from ns.suse.de ([213.95.15.193]:37647 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312681AbSEDMmD>;
	Sat, 4 May 2002 08:42:03 -0400
Date: Sat, 4 May 2002 14:42:02 +0200
From: Dave Jones <davej@suse.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: NeilBrown <neilb@cse.unsw.edu.au>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.13-dj1
Message-ID: <20020504144202.K30500@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Adrian Bunk <bunk@fs.tum.de>, NeilBrown <neilb@cse.unsw.edu.au>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020503185811.GA4846@suse.de> <Pine.NEB.4.44.0205041424390.283-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 04, 2002 at 02:29:44PM +0200, Adrian Bunk wrote:

 > Just FYI:
 > drivers/block/umem.c that comes from 2.4 doesn't compile:

 *nod*, I was just looking at that when going through the -dj2 diff.
 I think I'm going to drop it, as it needs quite a bit of work
 to be made 2.5 friendly.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
