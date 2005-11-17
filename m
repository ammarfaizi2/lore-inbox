Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbVKQP2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbVKQP2z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 10:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbVKQP2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 10:28:55 -0500
Received: from dave.ok.cz ([213.151.79.194]:39381 "EHLO awk.cz")
	by vger.kernel.org with ESMTP id S1750723AbVKQP2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 10:28:55 -0500
Date: Thu, 17 Nov 2005 16:28:16 +0100
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: USB patches for 2.6.15-rc1??
Message-ID: <20051117152816.GA28479@awk.cz>
References: <20051114200456.GA2319@kroah.com> <20051114200924.GA2531@kroah.com> <20051115084801.GA13387@awk.cz> <20051117005512.GB15140@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051117005512.GB15140@suse.de>
User-Agent: Mutt/1.5.11
From: David Kubicek <dave@awk.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2005 at 04:55:12PM -0800, Greg KH wrote:
> On Tue, Nov 15, 2005 at 09:48:01AM +0100, David Kubicek wrote:
> > may I ask you what about the "URB/buffer ring queue" patch I've
> > submitted months ago for CDC ACM modems and which you accepted into your
> > tree when Oliver sent it to you for merging like a week ago?
> 
> It's only been in my tree for a week.  It came to me after I had done
> the big merge cycle with Linus after 2.6.14 came out.  For major changes
> to a driver like this one, I want to get some good testing in the -mm
> tree, and then it will go into mainline.
> 
> So, it will be a few more weeks, I'll send it to Linus after 2.6.15 is
> out.

I see. Alright then, thank you very much. :)

-- 
David Kubíček
System Specialist

gedas ČR s.r.o.
Mladá Boleslav, Husova 217
Phone:  (420) 326 329 359
Mobile: (420) 724 073 280
Email:  dave@awk.cz
Web:    http://www.awk.cz
