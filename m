Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261238AbSKSHtM>; Tue, 19 Nov 2002 02:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263977AbSKSHtM>; Tue, 19 Nov 2002 02:49:12 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:61589 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S261238AbSKSHtL>;
	Tue, 19 Nov 2002 02:49:11 -0500
Date: Tue, 19 Nov 2002 08:56:14 +0100
From: bert hubert <ahu@ds9a.nl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Dax Kelson <dax@gurulabs.com>, "Grover, Andrew" <andrew.grover@intel.com>,
       pavel@ucw.cz, vojtech@suse.cz,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BK current compile failure
Message-ID: <20021119075614.GA25237@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Linus Torvalds <torvalds@transmeta.com>,
	Dax Kelson <dax@gurulabs.com>,
	"Grover, Andrew" <andrew.grover@intel.com>, pavel@ucw.cz,
	vojtech@suse.cz, Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1037683446.1530.9.camel@mentor> <Pine.LNX.4.44.0211182252280.24793-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211182252280.24793-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 11:03:54PM -0800, Linus Torvalds wrote:
> 
> On 18 Nov 2002, Dax Kelson wrote:
> >
> > Linus, do you want compile failure reports like below?
> 
> Well, I certainly prefer not to, simply because you might as well send 
> them to linux-kernel and get it resolved that way by some random person 
> who just happens to be awake.

This sounds slightly tinderboxy in Mozilla slang, perhaps that is an idea?

I know Ben (I think?) has a .config that currently compiles with 2.5 but
also includes almost everything that is working right now and so quickly
exposes stuff that breaks.

Perhaps we could set up a tinderbox like thing to autmatically assign 'BK
blame'.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
