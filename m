Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283194AbRLDS3k>; Tue, 4 Dec 2001 13:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281201AbRLDS2Y>; Tue, 4 Dec 2001 13:28:24 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:169 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S283208AbRLDS1Z>; Tue, 4 Dec 2001 13:27:25 -0500
Date: Tue, 4 Dec 2001 11:27:13 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dalecki@evision.ag, Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@caldera.de>,
        "Eric S. Raymond" <esr@thyrsus.com>, Keith Owens <kaos@ocs.com.au>,
        kbuild-devel@lists.sourceforge.net, torvalds@transmeta.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011204182713.GO17651@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20011204181337.GL17651@cpe-24-221-152-185.az.sprintbbd.net> <E16BKGx-0002y5-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16BKGx-0002y5-00@the-village.bc.nu>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 06:26:27PM +0000, Alan Cox wrote:
> > > > Python2 - which means most users dont have it.
> > 
> > Most users sure as hell shouldn't be playing with 2.5.x right now
> > anyways.  With any sort of 'luck' it'll be 6 months at least before
> > 2.5.x becomes stable enough that it will probably compile all the time
> > again and not have a random fs eating bug.  In 6 months even woody might
> > be frozen :)
> 
> It wont become stable if nobody can configure it because nobody will build
> it or run it. Lots of people build non stable kernels because its
> 
> a) fun
> b) a way to learn and play with the system
> c) they might make their own small fix and mark
> 
> not all of the them are demon kernel hackers.

But they can't install python2?  I _think_ there's src.rpms on
Python.org that will install as python2 even...

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
