Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283288AbRLDTad>; Tue, 4 Dec 2001 14:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282910AbRLDT3T>; Tue, 4 Dec 2001 14:29:19 -0500
Received: from t2.redhat.com ([199.183.24.243]:18418 "HELO mail.redhat.de")
	by vger.kernel.org with SMTP id <S283286AbRLDT24>;
	Tue, 4 Dec 2001 14:28:56 -0500
Date: Tue, 4 Dec 2001 20:28:54 +0100 (CET)
From: Bernhard Rosenkraenzer <bero@redhat.de>
X-X-Sender: brosenkr@bochum.stuttgart.redhat.com
To: "Eric S. Raymond" <esr@thyrsus.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@caldera.de>,
        Keith Owens <kaos@ocs.com.au>, <kbuild-devel@lists.sourceforge.net>,
        <torvalds@transmeta.com>
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
In-Reply-To: <20011204123831.J16578@thyrsus.com>
Message-ID: <Pine.LNX.4.42.0112042028080.10518-100000@bochum.stuttgart.redhat.com>
X-Spam-From: abuse@localhost
X-Spam-To: uce@ftc.gov
X-Subliminal-Message: Microsoft sucks! Update your system to Linux today! (http://www.redhat.com/download/)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2001, Eric S. Raymond wrote:

> Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > > I'm pretty sure that's true any more, Alan.  Red Hat shipped Python 2 in
> > > 7.1, so the RPM-based distros like KRUD and Mandrake have had it for
> > > seven months. Debian had it before that.   
> > 
> > RH shipped python2 beginning RH 7.2.
> 
> Eh?  I'm going to go check my old 7.1 CDs...

We shipped python2 as an extra package ever since 7.1, but it's not in any 
of the default installs because the standard tools still use python 1.5.x 
for compatibility reasons.

LLaP
bero

-- 
This message is provided to you under the terms outlined at
http://www.bero.org/terms.html

