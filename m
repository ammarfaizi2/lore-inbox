Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbTDOVqW (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 17:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264114AbTDOVqW 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 17:46:22 -0400
Received: from stroke.of.genius.brain.org ([206.80.113.1]:6562 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id S262770AbTDOVqV (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 17:46:21 -0400
Date: Tue, 15 Apr 2003 17:58:09 -0400
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Help with SiS 648 chipset and agpgart
Message-ID: <20030415215809.GE1249@Master.Bellsouth.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200304140439.08812.tlee5794@rushmore.com> <20030414230105.GD1249@Master.Bellsouth.net> <200304141933.48431.tlee5794@rushmore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304141933.48431.tlee5794@rushmore.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 07:33:48PM -0600, Tim Lee wrote:
> On Monday 14 April 2003 5:01 pm, Murray J. Root wrote:
> > On Mon, Apr 14, 2003 at 04:39:08AM -0600, Tim Lee wrote:
> > > Hi,
> > >
> > > I need to get agpgart to work with a SiS 648 chipset and I
> > > haven't seen any implementation of such yet.  I'm currently
> > > using a 2.4.19 kernel.  Without a working implementation I
> > > can't use accelerated OpenGL with an ATI Radeon 9500 pro
> > > because the ATI drivers require working agp support.  I've
> > > tried just using the generic-sis but that causes the driver
> > > to mess up big time.
> > >
> > > Any ideas?
> >
> > the SiS648 isn't in the main 2.4.x tree. It works in the -ac tree, though.
> 
> In what -ac, the most recent for the 2.4.21-pre7-ac1?

The last one that I used was 2.4.20<something> and it worked for agp.
I just use 2.5.x now cause it works a lot better with SiS chipsets (for
me, anyway).

-- 
Murray J. Root

