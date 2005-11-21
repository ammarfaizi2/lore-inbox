Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbVKUWJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbVKUWJV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbVKUWJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:09:21 -0500
Received: from mail.kroah.org ([69.55.234.183]:49545 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751119AbVKUWJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:09:20 -0500
Date: Mon, 21 Nov 2005 14:03:42 -0800
From: Greg KH <gregkh@suse.de>
To: Jody McIntyre <scjody@steamballoon.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       greg@kroah.com
Subject: Re: [RFC] HOWTO do Linux kernel development - take 2
Message-ID: <20051121220342.GB17983@suse.de>
References: <20051115210459.GA11363@kroah.com> <9a8748490511151421g2eb40cebyee78a88991867ac@mail.gmail.com> <20051115223057.GA12986@suse.de> <20051118054045.GW4940@conscoop.ottawa.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051118054045.GW4940@conscoop.ottawa.on.ca>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 12:40:45AM -0500, Jody McIntyre wrote:
> On Tue, Nov 15, 2005 at 02:30:58PM -0800, Greg KH wrote:
> 
> > I'm not meaning to duplicate anything, as we don't have "location of
> > development git/quilt tree" entry in the MAINTAINERS file.  Hm, that
> > does sound like the proper place for such an entry, doesn't it?  Anyone
> > want to propose that addition?
> 
> Sure :)
> 
> BTW Greg, you are not currently listed as an I2C maintainer.  Might
> want to fix that :)

That's because I am no longer the I2C maintainer, but still am the
conduit from patches from the current I2C maintainer, to the -mm and
Linus trees.  I know of other people in this kind of situation (like the
different network driver stuff.)

thanks,

gregk -h
