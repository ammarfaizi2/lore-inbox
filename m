Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbVCUBg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVCUBg5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 20:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261435AbVCUBg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 20:36:57 -0500
Received: from 63.reserved.callplus.net.nz ([203.184.21.63]:55308 "EHLO
	brick.flying-brick.caverock.net.nz") by vger.kernel.org with ESMTP
	id S261434AbVCUBgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 20:36:55 -0500
Date: Mon, 21 Mar 2005 13:36:12 +1200
From: viking <viking@flying-brick.caverock.net.nz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: USB mouse hiccups
Message-ID: <20050321013612.GA7168@flying-brick.caverock.net.nz>
References: <pan.2005.03.20.21.53.36.929746@brick.flying-brick.caverock.net.nz> <20050320164129.44d3a065.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050320164129.44d3a065.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 20, 2005 at 04:41:29PM -0800, Andrew Morton wrote:
> viking <viking@flying-brick.caverock.net.nz> wrote:
> >
> > I did note something strange. I'm running 2.6.11.2 at this moment, when I
> >  tried 2.6.11.3, my USB Microsoft Wireless Optical Mouse stopped moving
> >  from left to right, and would only move up and down if I physically moved
> >  the mouse from left to right. I didn't see anything in the patches that
> >  touched anything in the event handling, so frankly I'm puzzled.
> >  Any clues as to where I need to look? I've seen this problem before, but
> >  don't know what causes it, nor how I fixed it at the time.
> >  Also, how do I get that patch that enables the tiltwheel (left-right
> >  events)?
> 
> Could you please test 2.6.12-rc1?

Yeesh. You ARE keen, aren't you. I'll attempt to do so over the next day or
so. Thanks.

-- 
 /|   _,.:*^*:.,   |\  Cheers from the Viking family, including Pippin, our cat
| |_/'  viking@ `\_| |
|    flying-brick    | $FunnyMail   : What do you mean, I've lost the plot?
 \_.caverock.net.nz_/     5.40      : I planted them carrots right here!!
