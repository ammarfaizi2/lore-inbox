Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286541AbRLUUg6>; Fri, 21 Dec 2001 15:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286546AbRLUUgq>; Fri, 21 Dec 2001 15:36:46 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:18959 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S286541AbRLUUgh>; Fri, 21 Dec 2001 15:36:37 -0500
Date: Fri, 21 Dec 2001 18:36:22 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Chris Wedgwood <cw@f00f.org>, "Eric S. Raymond" <esr@thyrsus.com>,
        David Garfield <garfield@irving.iisd.sra.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help editorial policy
In-Reply-To: <20011221153136.G15926@redhat.com>
Message-ID: <Pine.LNX.4.33L.0112211835440.28489-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Dec 2001, Benjamin LaHaise wrote:
> On Sat, Dec 22, 2001 at 09:10:33AM +1300, Chris Wedgwood wrote:
> > And disks by the GB where GB == 1000^3 so I don't see any problem in
> > moving from KB to KiB and friends ESPECIALLY AS THEY ARE STANDARDIZED
> > BEYOND THE KERNEL and nothing will change this.
>
> If you think GB == 1000^3, then please go "correct" all the DRAM
> manufacturers out in the world.  They just sent me 1GB of ram and
> it's coming up as 1073741824 bytes.  Please help!  They have no
> option for GiB!!!

Also, a GB of disk space really is 2^10 * 10^6 ...

Better make sure we get it consistent ... *runs like hell*

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

