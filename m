Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263384AbTHXDt0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 23:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263417AbTHXDt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 23:49:26 -0400
Received: from mail.kroah.org ([65.200.24.183]:60056 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263384AbTHXDtZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 23:49:25 -0400
Date: Sat, 23 Aug 2003 20:49:12 -0700
From: Greg KH <greg@kroah.com>
To: Scott Lampert <scott@lampert.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB 2.0 and USB Sony DRU-500A unreliable
Message-ID: <20030824034912.GB10215@kroah.com>
References: <20030823162145.GA5229@cobalt.heavymetal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030823162145.GA5229@cobalt.heavymetal.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 23, 2003 at 09:21:45AM -0700, Scott Lampert wrote:
> 
> I have problems getting my Sony DRU-500A on an external USB 2.0 enclosure
> working reliably with my IOGear USB 2.0 card on any of the late
> 2.5.x/2.6.0-test kernels. The enclosure is a generic "Made in China"
> brand (PPA, Inc?).  The drive seems to read data fine for a little while
> and then just "shuts down" and stops reading, irregardless of what kind
> of media I have in it. This same configuration (exact same hardware)
> works fine under Windows. :(
> 
> Attached is all the data about the various components I thought might be
> useful and the output of UMass debug right when it starts to fail.  If
> there is some more data needed, or I'm sending to the wrong list, or
> ideas for things to try please let me know.

Try sending this to the linux-usb-devel mailing list.

Good luck,

greg k-h
