Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbVLOU6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbVLOU6m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 15:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbVLOU6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 15:58:42 -0500
Received: from twinlark.arctic.org ([207.7.145.18]:38021 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id S1751080AbVLOU6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 15:58:42 -0500
Date: Thu, 15 Dec 2005 12:58:40 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
cc: martin <stillflame@freegeek.org>, linux-kernel@vger.kernel.org
Subject: Re: mounting loopback device partitions
In-Reply-To: <Pine.LNX.4.63.0512142209490.7172@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.63.0512151258150.7172@twinlark.arctic.org>
References: <20051215041227.GF43089@faeriemud.org>
 <Pine.LNX.4.64.0512142210490.26888@montezuma.fsmlabs.com>
 <Pine.LNX.4.63.0512142209490.7172@twinlark.arctic.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2005, dean gaudet wrote:

> 
> 
> On Wed, 14 Dec 2005, Zwane Mwaikambo wrote:
> 
> > On Wed, 14 Dec 2005, martin wrote:
> > 
> > > this is a wishlistish feature request.
> > > 
> > > i would like to be able to partition a loopback device,
> > > and then mount those partitions.
> > > 
> > > sorry i couldn't find the loopback maintainer to send this to.
> > 
> > http://www.mega-tokyo.com/osfaq2/index.php/Disk%20Images%20Under%20Linux
> 
> the only problem with this technique is you can't set the limit for a 
> loopback... only the offset...
> 
> istr someone posted a script which used fdisk -l and dmsetup to create 
> properly offset/limited loopback partition devices... or maybe that was 
> just what several people said would be the cool way to solve it :)

found it...

http://www.ussg.iu.edu/hypermail/linux/kernel/0307.2/0935.html

-dean
