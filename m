Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289328AbSBZXya>; Tue, 26 Feb 2002 18:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289243AbSBZXyV>; Tue, 26 Feb 2002 18:54:21 -0500
Received: from ns.suse.de ([213.95.15.193]:6925 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289307AbSBZXyB>;
	Tue, 26 Feb 2002 18:54:01 -0500
Date: Wed, 27 Feb 2002 00:52:14 +0100
From: Dave Jones <davej@suse.de>
To: Roberto Nibali <ratz@drugphish.ch>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.5-dj2
Message-ID: <20020227005214.D9189@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Roberto Nibali <ratz@drugphish.ch>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020226223406.A26905@suse.de> <3C7C1AF0.3000103@drugphish.ch> <20020227003905.C9189@suse.de> <3C7C1D3B.5050202@drugphish.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C7C1D3B.5050202@drugphish.ch>; from ratz@drugphish.ch on Wed, Feb 27, 2002 at 12:41:47AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 12:41:47AM +0100, Roberto Nibali wrote:
 > Why not include it into /home/davej/.exclude?
 > Regarding ALSA and showing up with their own ``version.h''; what about 
 > the others?

 Possibly the easier way, I removed it before when ALSA was new
 so that its version.h showed up in the patch. (It wouldnt compile
 without it in 2.4.4-dj)

 Since I rediffed against 2.5.5, this isn't a problem.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
