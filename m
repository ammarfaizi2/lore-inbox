Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261991AbSIYOyo>; Wed, 25 Sep 2002 10:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261993AbSIYOyo>; Wed, 25 Sep 2002 10:54:44 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:22280 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261991AbSIYOyn>;
	Wed, 25 Sep 2002 10:54:43 -0400
Date: Wed, 25 Sep 2002 07:58:43 -0700
From: Greg KH <greg@kroah.com>
To: wbh <W.B.Hill@uea.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Y-251U drive adapter/USB
Message-ID: <20020925145843.GB30339@kroah.com>
References: <Pine.OSF.4.05.10209251103370.16852-200000@cpca7.uea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10209251103370.16852-200000@cpca7.uea.ac.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 11:13:10AM +0100, wbh wrote:
> Hi. I got a Y-251U USB drive enclosure this morning, as at
> http://www.cable-world.com/newproduct/USB10HDD.htm
> Doesn't appear to work with Linux by default, but it's based on the
> GL241USB chip and a Compact Flash reader based on that works,
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0204.2/1445.html
> So, altering it slightly I get the attached patch, which works for me.

Can you please send this patch to the author and maintainer of the
usb-storage driver?

thanks,

greg k-h
