Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263159AbUGMGbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbUGMGbv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 02:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbUGMGbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 02:31:51 -0400
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:34772 "EHLO
	snipe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S263159AbUGMGbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 02:31:49 -0400
Date: Tue, 13 Jul 2004 02:31:45 -0400
From: Paul Winkler <pw_lists@slinkp.com>
To: "The Linux Audio Developers' Mailing List" 
	<linux-audio-dev@music.columbia.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040713063145.GA14583@slinkp.com>
Mail-Followup-To: Paul Winkler <pw_lists@slinkp.com>,
	The Linux Audio Developers' Mailing List <linux-audio-dev@music.columbia.edu>,
	linux-kernel@vger.kernel.org
References: <20040709182638.GA11310@elte.hu> <20040710222510.0593f4a4.akpm@osdl.org> <1089673014.10777.42.camel@mindpipe> <20040712163141.31ef1ad6.akpm@osdl.org> <1089677823.10777.64.camel@mindpipe> <1089689478.2523.16.camel@rivendell.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089689478.2523.16.camel@rivendell.home.local>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2004 at 08:31:18PM -0700, Florin Andrei wrote:
> On Mon, 2004-07-12 at 17:17, Lee Revell wrote:
> 
> > There is an overwhelming consensus amongst Linux audio
> > folks that you should use reiserfs for low latency work.
> 
> I doubt the "overwhelming consensus" part. 

me too, but at some point in the 2.4 kernel cycle,  
reiserfs came out much better than ext3 in some latency tests* that 
were reported on linux-audio-dev and linux-audio-user lists.
This seems to have left many of us musicianly types with a vague 
"reiser good, ext3 bad" mindset.


* i think it was this:
http://myweb.cableone.net/eviltwin69/Arcana.html#Mark%20Knecht's%20filesystem%20tests
 
-- 

Paul Winkler
http://www.slinkp.com
