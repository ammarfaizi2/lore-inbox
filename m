Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWBIQAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWBIQAv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 11:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbWBIQAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 11:00:51 -0500
Received: from atpro.com ([12.161.0.3]:58633 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S932318AbWBIQAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 11:00:50 -0500
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Thu, 9 Feb 2006 11:00:35 -0500
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: peter.read@gmail.com, matthias.andree@gmx.de, lsorense@csclub.uwaterloo.ca,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060209160035.GD18918@voodoo>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	peter.read@gmail.com, matthias.andree@gmx.de,
	lsorense@csclub.uwaterloo.ca, linux-kernel@vger.kernel.org
References: <43E7545E.nail7GN11WAQ9@burner> <73d8d0290602060706o75f04c1cx@mail.gmail.com> <43E7680E.2000506@gmx.de> <20060206205437.GA12270@voodoo> <43E89B56.nailA792EWNLG@burner> <20060207183712.GC5341@voodoo> <43E9F1CD.nail2BR11FL52@burner> <20060208210219.GB9166@DervishD> <20060208211455.GC2480@csclub.uwaterloo.ca> <43EB1988.nail7EL2I7AN6@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43EB1988.nail7EL2I7AN6@burner>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/06 11:29:28AM +0100, Joerg Schilling wrote:
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
> 
> Jörg

I've been using the cdrecord packaged by Debian for years without a single
problem and it has 35 patches included in the source package. Please
enlighten me as to what they've broken because obviously none of it has
affected me.

Jim.
