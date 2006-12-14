Return-Path: <linux-kernel-owner+w=401wt.eu-S932768AbWLNPFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932768AbWLNPFI (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 10:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932765AbWLNPFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 10:05:07 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4618 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750839AbWLNPFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 10:05:05 -0500
Date: Thu, 14 Dec 2006 16:05:14 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dave Jones <davej@redhat.com>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@osdl.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Message-ID: <20061214150514.GI3629@stusta.de>
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net> <20061214005532.GA12790@suse.de> <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org> <4580E37F.8000305@mbligh.org> <20061214130704.GB17565@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061214130704.GB17565@redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 08:07:04AM -0500, Dave Jones wrote:
> On Wed, Dec 13, 2006 at 09:39:11PM -0800, Martin J. Bligh wrote:
> 
>  > The Ubuntu feisty fawn mess was a dangerous warning bell of where we're
>  > going. If we don't stand up at some point, and ban binary drivers, we
>  > will, I fear, end up with an unsustainable ecosystem for Linux when
>  > binary drivers become pervasive. I don't want to see Linux destroyed
>  > like that.
> 
> Thing is, if kernel.org kernels get patched to disallow binary modules,
> whats to stop Ubuntu (or anyone else) reverting that change in the
> kernels they distribute ?  The landscape doesn't really change much,
> given that the majority of Linux end-users are probably running
> distro kernels.

If a kernel developer or a competitor sends a cease&desist letter to 
such a distribution, the situation changes from a complicated "derived 
work" discussion to a relatively clear "They circumvented a technical 
measure to enforce the copyright.".

> 		Dave

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

