Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263952AbTDJEKe (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 00:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263954AbTDJEKd (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 00:10:33 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:49038 "EHLO
	nessie.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S263952AbTDJEKc (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 00:10:32 -0400
Date: Thu, 10 Apr 2003 14:20:15 +1000
From: CaT <cat@zip.com.au>
To: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org,
       neilb@cse.unsw.edu.au
Subject: Re: 2.5->2.4 nfs corrupts
Message-ID: <20030410042015.GD467@zip.com.au>
References: <20030410013349.GC467@zip.com.au> <20030410014417.GA3197@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030410014417.GA3197@suse.de>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 10, 2003 at 02:44:17AM +0100, Dave Jones wrote:
> On Thu, Apr 10, 2003 at 11:33:49AM +1000, CaT wrote:
>  > nfs server: 2.4.21-pre2
>  > nfs client: 2.5.67
> 
> Quite a few people (myself included) are seeing this.
> >From the reports I've seen so far, it looks like it only
> happens when the client is a faster box than the server.
> In my case, I have a 2.8Ghz P4 as the client, hammering
> a poor defenceless 1Ghz VIA C3.

This is the case here also: a p3 700 hammering a k6 300.

> This is probably worth creating a bugzilla entry for.

Would this be something I'd do or someone else?

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
