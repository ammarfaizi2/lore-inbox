Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbVKGRUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbVKGRUI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbVKGRUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:20:08 -0500
Received: from mail.kroah.org ([69.55.234.183]:21978 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964878AbVKGRUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:20:06 -0500
Date: Mon, 7 Nov 2005 09:00:15 -0800
From: Greg KH <greg@kroah.com>
To: Miles Bader <miles@gnu.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver Core: document struct class_device properly
Message-ID: <20051107170015.GB15586@kroah.com>
References: <11304810242041@kroah.com> <200510280154.59943.dtor_core@ameritech.net> <20051028190937.GA16822@kroah.com> <buopspcc2fw.fsf@dhapc248.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <buopspcc2fw.fsf@dhapc248.dev.necel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 05:00:35PM +0900, Miles Bader wrote:
> Greg KH <greg@kroah.com> writes:
> >> What about Kay's proposal about moving (as far as userspace concerned)
> >> everything into /sys/devices?
> >
> > That's exactly what I am now working on.  But it will take much longer
> > than 2.6.15 to get there for that.  More like the next 6 months or so at
> > the least...
> 
> BTW, is there a reason why "devices" is plural, as opposed to the
> singular names used for other directories holding types of objects
> ("/sys/class" "/sys/bus" "/dev" "/lib" etc.)?

That's just the way it happened, no real "reason" behind it :)

thanks,

greg k-h
