Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVBWX2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVBWX2n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 18:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbVBWXYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 18:24:49 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:28119 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261687AbVBWXX6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 18:23:58 -0500
Message-ID: <421D11A9.1090708@tmr.com>
Date: Wed, 23 Feb 2005 18:28:41 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org
Subject: Re: OT: Why is usb data many times the cpu hog that firewire is?
References: <200502211216.35194.gene.heskett@verizon.net>
In-Reply-To: <200502211216.35194.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> Greetings;
> 
> Motherboard is a biostar with nforce2 chipset, 2800xp cpu, gig of ram.
> 
> I've recently made the observation that while I can view 30fps video 
> from my firewire equipt movie camera with a minimal cpu hit of 2-3%, 
> but viewing the video from a webcam on a usb 1.1 circuit takes 30-40% 
> of the cpu, at half the frame rate.

You have gotten most of an answer, unless someone make a fireware to 
USB2 adaptor you are going to have to go slow or run firewire.

I would think the framerate could be quite slow and still be useful. 
What software do you use to do the detection (curiousity only)? Of 
course after you detect motion you probably want to up the framerate, so 
  you can see what's really happening.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
