Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262604AbSKYHYU>; Mon, 25 Nov 2002 02:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262620AbSKYHYU>; Mon, 25 Nov 2002 02:24:20 -0500
Received: from stroke.of.genius.brain.org ([206.80.113.1]:58266 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S262604AbSKYHYT>; Mon, 25 Nov 2002 02:24:19 -0500
Date: Mon, 25 Nov 2002 02:31:10 -0500
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: Re: keyboard and mouse lost in X
Message-ID: <20021125073110.GC1628@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021125070418.GB1628@Master.Wizards> <Pine.LNX.4.50.0211250217110.1462-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0211250217110.1462-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2002 at 02:20:55AM -0500, Zwane Mwaikambo wrote:
> On Mon, 25 Nov 2002, Murray J. Root wrote:
> 
> > Mandrake's 2.4.20-0.3mdk kernel doesn't have this problem, and it is
> > based on 2.4.20-rc2. So - where would I start looking for the possible
> > differences that could be causing it in the 2.4.20-rc2/rc3? Mandrake
> > adds too many patches for me to just shoot in the dark.
> 
> Try and backtrack from a working kernel till you find a kernel which
> doesn't work. Then you can check the diff between the non working and the
> last working kernel
>
 
2.4.20-pre8 is the last working one - and the diffs are huge. I was 
hoping for a pointer to a module to look at - the whole thing is a bit 
large.

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.freenode.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker 

