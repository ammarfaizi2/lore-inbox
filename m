Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161024AbWBNMO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161024AbWBNMO4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 07:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161027AbWBNMO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 07:14:56 -0500
Received: from smtp.enter.net ([216.193.128.24]:16649 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1161024AbWBNMO4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 07:14:56 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Tue, 14 Feb 2006 07:21:24 -0500
User-Agent: KMail/1.8.1
Cc: Valdis.Kletnieks@vt.edu, peter.read@gmail.com, mj@ucw.cz,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jerome.lacoste@gmail.com,
       jengelh@linux01.gwdg.de
References: <20060208162828.GA17534@voodoo> <200602131919.k1DJJF5G025923@turing-police.cc.vt.edu> <43F1C385.nailMWZ599SQ5@burner>
In-Reply-To: <43F1C385.nailMWZ599SQ5@burner>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602140721.25066.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 February 2006 06:48, Joerg Schilling wrote:
> Valdis.Kletnieks@vt.edu wrote:
> > On Mon, 13 Feb 2006 17:37:18 +0100, Joerg Schilling said:
> > > And if you have a working vold on Solaris, libscg accepts the vold
> > > aliases.
> >
> > And if you have a working hald on Linux, libscg should therefor accept
> > hald aliases.
>
> How about pointing to _useful_ documentation:
>
> -	How to find _any_ device that talks SCSI?
>
> -	How does HAL allow one cdrecord instance to work
> 	without being interrupted by HAL?
>
> -	How to send non disturbing SCSI commands from another
> 	cdrecord process in case one or more are already running?
>
> Jörg

Documentation?

Didn't even take me two minutes to find the entire specification for hald on 
the net.

http://cvs.freedesktop.org/*checkout*/hal/hal/doc/spec/hal-spec.html?only_with_tag=HEAD

theres a link. if I wasn't half asleep I'd actually dig through it and find 
the information you're asking about.

DRH
