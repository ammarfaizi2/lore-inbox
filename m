Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261541AbSLCO6y>; Tue, 3 Dec 2002 09:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261545AbSLCO6y>; Tue, 3 Dec 2002 09:58:54 -0500
Received: from [207.34.24.15] ([207.34.24.15]:23940 "EHLO mail")
	by vger.kernel.org with ESMTP id <S261541AbSLCO6y>;
	Tue, 3 Dec 2002 09:58:54 -0500
Message-ID: <3DECC85F.40100@infointeractive.com>
Date: Tue, 03 Dec 2002 11:06:07 -0400
From: Rob Shortt <rob@infointeractive.com>
Organization: InfoInterActive Corp., An AOL Company
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020910
MIME-Version: 1.0
To: Paul Richards <greytek@lycos.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.19 rivafb updates
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This patch provides the ability to work with LCDs, bug fixes to cleanup 
> code, Mac support, and support for more nvidia cards. The Mac code was 
> added from a patch Ani Joshi sent me.

> http://rain.prohosting.com/scftpd/rivafb-richards1.diff.gz


Hi Paul,

First of all, thanks for this patch!  I came accross it while searching 
the archives last night.  I am using a GeForce4 MX440 and have applied 
your patch, now rivafb successfully detects my card.

I am trying to use rivefb with my TV as the (only) display.  I have 
tried an 800x600 mode @ 60 Hz which from what I read is optimal for 
TV's, also this is the mode I use when using X to display on my TV. 
With rivafb in this mode (similar results for other modes) my display is 
totally garbled with rectangles of colours going everywhere.

My question is does something need to change with regard to rivafb to 
play nice with a television as the display or do I just need to keep 
searching for a better modeline?  I will be testing the patched rivafb 
this evening with a regular monitor to make sure that works as well.

Once again, thanks!  If anyone else on this list has any input that also 
would be appreciated.

-Rob Shortt


