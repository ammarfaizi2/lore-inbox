Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318182AbSGRQPc>; Thu, 18 Jul 2002 12:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318227AbSGRQPb>; Thu, 18 Jul 2002 12:15:31 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:64773 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318182AbSGRQPb>;
	Thu, 18 Jul 2002 12:15:31 -0400
Date: Thu, 18 Jul 2002 09:17:11 -0700
From: Greg KH <greg@kroah.com>
To: Guillaume Boissiere <boissiere@adiglobal.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
Message-ID: <20020718161711.GD15037@kroah.com>
References: <3D361091.13618.16DC46FB@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D361091.13618.16DC46FB@localhost>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Thu, 20 Jun 2002 15:05:16 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 12:49:21AM -0400, Guillaume Boissiere wrote:
> o Replace initrd by initramfs                     (H. Peter Anvin, Al Viro)

A few of the features above, need this feature, so I would move it up to
"before feature freeze".  Well I hope it happens, that way we can
actually get most of the above done :)

And there are patches available for this on Al Viro's site, but I don't
know the current state of them.

thanks,

greg k-h
