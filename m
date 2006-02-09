Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422651AbWBIKx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422651AbWBIKx3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 05:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422881AbWBIKx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 05:53:29 -0500
Received: from mail.gmx.de ([213.165.64.21]:63667 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422651AbWBIKx2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 05:53:28 -0500
X-Authenticated: #428038
Date: Thu, 9 Feb 2006 11:53:24 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: peter.read@gmail.com, matthias.andree@gmx.de, lsorense@csclub.uwaterloo.ca,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060209105324.GC15173@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	peter.read@gmail.com, lsorense@csclub.uwaterloo.ca,
	linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net
References: <43E7545E.nail7GN11WAQ9@burner> <73d8d0290602060706o75f04c1cx@mail.gmail.com> <43E7680E.2000506@gmx.de> <20060206205437.GA12270@voodoo> <43E89B56.nailA792EWNLG@burner> <20060207183712.GC5341@voodoo> <43E9F1CD.nail2BR11FL52@burner> <20060208210219.GB9166@DervishD> <20060208211455.GC2480@csclub.uwaterloo.ca> <43EB1988.nail7EL2I7AN6@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43EB1988.nail7EL2I7AN6@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-09:

> lsorense@csclub.uwaterloo.ca (Lennart Sorensen) wrote:
> 
> > Hmm, perhaps what should be done is that someone needs to write and
> > maintain a patch that linux users can apply to cdrecord (since other OSs
> > are different and hence have no reason to use such a patch), to make it
> > behave in a manner which is sane on linux.  It should of course be
> > clearly marked as having been changed in such a way.  It should use udev
> > if available and HAL and whatever else is appropriate on a modern linux
> > system, and if on an old system it should at least not break the
> > interfaces that already worked on those systems in cdrecord.
> 
> Unfortunately is it a matter oif facts that all known patches for cdrecord
> break more things than they claim to fix.

So prove my patch is wrong, and give a detailed report what it breaks,
unless you wish to fix it yourself.

-- 
Matthias Andree
