Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135858AbRDTKg5>; Fri, 20 Apr 2001 06:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135856AbRDTKgk>; Fri, 20 Apr 2001 06:36:40 -0400
Received: from sulphur.cix.co.uk ([212.35.225.149]:28927 "EHLO
	sulphur.cix.co.uk") by vger.kernel.org with ESMTP
	id <S135858AbRDTKgV>; Fri, 20 Apr 2001 06:36:21 -0400
X-Envelope-From: patrick@tykepenguin.cix.co.uk
Date: Fri, 20 Apr 2001 11:34:19 +0100
From: Patrick Caulfield <caulfield@sistina.com>
To: linux-lvm@sistina.com
Cc: AJ Lewis <lewis@sistina.com>, linux-kernel@vger.kernel.org,
        linux-openlvm@nl.linux.org
Subject: Re: [linux-lvm] Re: [repost] Announce: Linux-OpenLVM mailing list
Message-ID: <20010420113419.B569@tykepenguin.com>
Mail-Followup-To: linux-lvm@sistina.com, AJ Lewis <lewis@sistina.com>,
	linux-kernel@vger.kernel.org, linux-openlvm@nl.linux.org
In-Reply-To: <20010419142400.E10345@sistina.com> <200104191945.f3JJjKRn015661@webber.adilger.int> <20010419145337.K10345@sistina.com> <3ADF45FC.EE7B2003@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ADF45FC.EE7B2003@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Apr 19, 2001 at 04:09:32PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2001 at 04:09:32PM -0400, Jeff Garzik wrote:
> AJ Lewis wrote:
> > Ok, the issue here is that we're trying to get a release out and so anything
> > that majorly changes the code is getting shunted aside for the moment.  It
> > would be stupid to just add everything that comes in on the ML without
> > review.  Linus does the exact same thing.  I've said this before to you
> > Andreas, but apparently you feel that you should have final say on whether
> > your patches go in or not.
> 
> > As far as getting patches into the stock kernel, we've been sending patches
> > to Linus for over a month now, and none of them have made it in.  Maybe
> > someone has some pointers on how we get our code past his filters.
> 
> Read Documentation/SubmittingPatches, and also listen to kernel hackers
> who know the block layer and want to fix lvm.

OK, we're in the process of splitting the big patch up into nice clean small
patches to go to Linus. Hopefully this should be done today, or very shortly at
least.


patrick

