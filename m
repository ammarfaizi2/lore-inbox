Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267678AbSLTBWM>; Thu, 19 Dec 2002 20:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267682AbSLTBWM>; Thu, 19 Dec 2002 20:22:12 -0500
Received: from jonquil.thebachchoir.org.uk ([138.37.90.250]:57611 "EHLO
	jonquil.thebachchoir.org.uk") by vger.kernel.org with ESMTP
	id <S267678AbSLTBWM>; Thu, 19 Dec 2002 20:22:12 -0500
Date: Fri, 20 Dec 2002 01:30:01 +0000 (GMT)
From: Matt Bernstein <matt@theBachChoir.org.uk>
X-X-Sender: mb@jester.mews
To: Ed Tomlinson <tomlins@cam.org>
cc: Paul P Komkoff Jr <i@stingr.net>, linux-kernel@vger.kernel.org,
       Dave Jones <davej@suse.de>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [drm:drm_init] *ERROR* Cannot initialize the agpgart module.
In-Reply-To: <20021217125013.29A57B63@oscar.casa.dyndns.org>
Message-ID: <Pine.LNX.4.51.0212200127001.877@jester.mews>
References: <200212162049.16039.tomlins@cam.org> <20021217080626.GE2496@stingr.net>
 <20021217125013.29A57B63@oscar.casa.dyndns.org>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-uvscan-result: clean (18PBzI-0001P4-00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 17 Ed Tomlinson wrote:

>Not normally.  If I modprobe via-agp modprobe segfaults (a Rusty's bug),
>but via_agp and agpgart get loaded (note that - changed to _ when the module 
>is loaded - it has dash in file in the directory).  Doing it this time gets 
>an oops (52bk as of last night):
[snip]

I get a very similar oops, but with amd_k7_agp (2.5.52-mm2). I'm not 
bk-savvy as yet, but if pointed at a diff, would be happy to verify it.

Matt
