Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbTDHMiF (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 08:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbTDHMiF (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 08:38:05 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:35767 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261335AbTDHMiE (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 08:38:04 -0400
Date: Tue, 8 Apr 2003 14:49:39 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] New kernel tree for embedded linux
Message-ID: <20030408124939.GE21794@wohnheim.fh-wedel.de>
References: <20030407171037.GB8178@wohnheim.fh-wedel.de> <20030407204812.GD17151@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030407204812.GD17151@ip68-0-152-218.tc.ph.cox.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 April 2003 13:48:12 -0700, Tom Rini wrote:
> On Mon, Apr 07, 2003 at 07:10:37PM +0200, J?rn Engel wrote:
> 
> > Some days ago, I've started a -je [*] tree which will focus on memory
> > reduction for the linux kernel.
> 
> First, I'd like to say please, no, everyone can benefit from _every
> change_ you want to make in your tree, and it's not just an 'embedded'
> issue.

Right. The purpose of this tree is not to keep changes out of
mainline, but to test and enhance some of the uglier ones before they
go in.
In a perfect world, my tree would contain exactly zero patches. :)

> Second, please look up the archives (this past June -> August maybe?)
> for the CONFIG_TINY thread.  Under that was my TWEAKS idea.  If this
> sounds useful to you, I can try and dig up the last patch I had that got
> all of the dependancy stuff correct, except that you had to run a
> command if you changed a TWEAK value.

Will do. Just give me a little time.

Jörn

-- 
There's nothing better for promoting creativity in a medium than
making an audience feel "Hmm ­ I could do better than that!"
-- Douglas Adams in a slashdot interview
