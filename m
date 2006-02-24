Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbWBXRdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWBXRdG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 12:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWBXRdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 12:33:06 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:40461 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932399AbWBXRdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 12:33:05 -0500
Date: Fri, 24 Feb 2006 18:33:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: Dave Jones <davej@redhat.com>, Dmitry Torokhov <dtor_core@ameritech.net>,
       davej@codemonkey.org.uk, Zwane Mwaikambo <zwane@commfireservices.com>,
       Samuel Masham <samuel.masham@gmail.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, cpufreq@lists.linux.org.uk
Subject: Re: Status of X86_P4_CLOCKMOD?
Message-ID: <20060224173303.GE3674@stusta.de>
References: <20060214152218.GI10701@stusta.de> <200602240055.30603.ak@suse.de> <20060224023937.GC3674@stusta.de> <200602240342.04573.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602240342.04573.ak@suse.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 03:42:02AM +0100, Andi Kleen wrote:
> On Friday 24 February 2006 03:39, Adrian Bunk wrote:
> 
> > We need an additional option for such cases, but overloading EMBEDDED 
> > with more than one meaning is definitely not a good idea.
> 
> I think it works just fine.

It works in the way that users don't see this option.

Both for this purpose, BROKEN or even simply removing the option would 
work equally well...

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

