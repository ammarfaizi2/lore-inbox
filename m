Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266898AbTAISE7>; Thu, 9 Jan 2003 13:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266907AbTAISE7>; Thu, 9 Jan 2003 13:04:59 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:4051 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S266898AbTAISE6>;
	Thu, 9 Jan 2003 13:04:58 -0500
Date: Thu, 9 Jan 2003 10:13:41 -0800
To: "Joshua M. Kwan" <joshk@ludicrus.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Wireless Extensions v16-3 - clean patches
Message-ID: <20030109181340.GB24023@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030109043119.GA13910@kanoe.ludicrus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030109043119.GA13910@kanoe.ludicrus.net>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 08:31:19PM -0800, Joshua M. Kwan wrote:
> Hi Jean,
> 
> I have attached two patches that allow current 2.5.54 BK and 2.4.20
> vanilla to patch cleanly from whatever WE they came with to WE16,
> from your site. This is easier since the patches on your website for
> 2.4.20 require two patches, and the 2.5.x one has a single reject
> that was not hard to resolve (just a few line breaks here and there
> and editing of the surrounding text confused patch.)
> 
> For 2.5, the BK i diffed against was a fresh tree from today, but
> since you're the one that makes all the changes to those files
> anyway, it really doesn't matter until a new WE is pushed! And then
> this patch won't be necessary at all :)
> 
> Both patches should be placed in the root of the source tree and
> applied with -p0.
> 
> Hope this can benefit others who would like to easily upgrade their
> WE :)
> 
> Regards
> Josh

	Thanks for the good work !

	For 2.4.X : 2.4.21-pre2 has WE-15, so if you get it it's only
one patch (the one on my page).
	For 2.5.X : my Pcmcia cards still don't work with 2.5.54, so
I'm currently no too worried about 2.5.X at the moment.
	Also, the current WE16-3 may not be the final version, as I'm
waiting for feedback from driver authors. Talking of feedback, which
part of WE16 do you need and why ?

	Have fun...

	Jean
