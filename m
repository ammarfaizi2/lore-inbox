Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265780AbUEZTfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265780AbUEZTfo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 15:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265781AbUEZTfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 15:35:44 -0400
Received: from grunt22.ihug.com.au ([203.109.249.142]:46046 "EHLO
	grunt22.ihug.com.au") by vger.kernel.org with ESMTP id S265780AbUEZTfm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 15:35:42 -0400
Subject: Re: [Fwd: Re: drivers DB and id/ info registration]
From: Zenaan Harkness <zen@freedbms.net>
To: linux-kernel@vger.kernel.org, debian-devel@lists.debian.org
In-Reply-To: <20040526182919.GA25978@kroah.com>
References: <1085548092.2909.60.camel@zen8100a.freedbms.net>
	 <20040526182919.GA25978@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1085600051.2468.17.camel@zen8100a.freedbms.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 27 May 2004 05:34:11 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-05-27 at 04:29, Greg KH wrote:
> On Wed, May 26, 2004 at 03:08:13PM +1000, Zenaan Harkness wrote:
> > I think we need to somehow make it easy for manufacturers to submit
> > information about their hardware - something centralized, kernel- and
> > distro- neutral, that can be widely advertised to manufacturers.
> 
> What kind of information?  Device ids are pretty useless in and of
> themselves.  What we need are device specs in order to produce proper
> drivers.  Without that information, just having a device id is
> pointless.

Except if a manufacturer actually went to the trouble of listing their
device id, name and email or web contact, then they may well get a
better picture of how many people are (attempting) to user their device
on a free os.

If, when I plug in my widget, I get a dialog saying "Your Funky Widget
X has been detected but has no driver, <click here> to send an email
requesting support." it is reassuring to me that my "OS" recognizes the
device, it is easy for me to see that there is currently no driver
(saves me googling for how long?) and makes it easy to register my
interest in getting support. Registration might go via this centralized
repository then to the company, for tracking.

So of course, the question is how many companies will submit only
device identification information?

Perhaps users can submit some, and surely at least _some_ companies,
and/ or their employees, will do so too.

Still pointless?

ta
zen
