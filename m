Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261287AbTCYAJD>; Mon, 24 Mar 2003 19:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261294AbTCYAJC>; Mon, 24 Mar 2003 19:09:02 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:48346 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S261287AbTCYAJA>; Mon, 24 Mar 2003 19:09:00 -0500
Date: Tue, 25 Mar 2003 01:16:27 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Craig Thomas <craiger@osdl.org>
Cc: Scott Robert Ladd <coyote@coyotegulch.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Testing: What do you want?
Message-ID: <20030325001627.GC14469@wohnheim.fh-wedel.de>
References: <3E7F1A2D.4050306@coyotegulch.com> <1048525274.25652.3.camel@irongate.swansea.linux.org.uk> <1048547186.495.43.camel@bullpen.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1048547186.495.43.camel@bullpen.pdx.osdl.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 March 2003 15:06:26 -0800, Craig Thomas wrote:
> 
> OSDL has a set of stress tests that are run on new kernels as they
> become available.  However, the architectures tested are limited
> (compared with the variety that can be found in the world).  There 
> are enough testers in the community to collectively test for 
> correctness of the kernel.  Test suites such as LTP and LSB help
> in this regard.
> 
> On Mon, 2003-03-24 at 09:01, Alan Cox wrote:
> > 
> > One of the best things people can do is just use it. OSDL and others run
> > stress tests but often its users configurations that find bugs not
> > stress and coverage runs.

And another thing I have found to be good at finding bugs is a sick
mind. If you intend to crash a system and do just about anything a
normal user wouldn't, you will stress all the code paths that are
usually not tested.

Jörn

-- 
To recognize individual spam features you have to try to get into the
mind of the spammer, and frankly I want to spend as little time inside
the minds of spammers as possible.
-- Paul Graham
