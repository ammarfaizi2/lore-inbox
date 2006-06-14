Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965052AbWFOAQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbWFOAQk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 20:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbWFOAQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 20:16:39 -0400
Received: from mail.kroah.org ([69.55.234.183]:11221 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965052AbWFOAQj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 20:16:39 -0400
Date: Wed, 14 Jun 2006 16:45:04 -0700
From: Greg KH <gregkh@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH RFC] maxSize option for usb-serial to increase max endpoint buffer size
Message-ID: <20060614234504.GA23897@suse.de>
References: <447DFBC5.70200@goop.org> <20060531203803.GA7735@suse.de> <448DEA4E.7000707@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448DEA4E.7000707@goop.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2006 at 03:27:26PM -0700, Jeremy Fitzhardinge wrote:
> Greg KH wrote:
> >I've been working with Ken on getting this driver to work better
> >(meaning faster).  Here's the latest version (without your new device id
> >added).  Care to test it out and let me know if it works or not?
> >  
> I've been exercising this fairly heavily for the last few hours, and it 
> looks pretty solid - no problems at all.

Thanks for the feedback.  Others report that it doesn't work at all, so
I'm going to work on it some more before submitting it for real :)

thanks,

greg k-h
