Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWGKW1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWGKW1U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 18:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWGKW1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 18:27:20 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:8712 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932084AbWGKW1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 18:27:19 -0400
Date: Wed, 12 Jul 2006 00:27:18 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>, torvalds@osdl.org, akpm@osdl.org
Subject: Re: RFC: cleaning up the in-kernel headers
Message-ID: <20060711222718.GF13938@stusta.de>
References: <20060711160639.GY13938@stusta.de> <20060711170725.GD5362@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711170725.GD5362@redhat.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 01:07:25PM -0400, Dave Jones wrote:
>...
> ghviz & hviz from http://www.kernel.org/pub/linux/kernel/people/acme/
> are invaluable for eyeballing include dependancies btw.
> They need graphviz installed, and run like so..
> 
> ghviz include/linux/sched.h 10
> 
> to produce a pretty graph.

I'll need something like this. It's not exactly what I have in mind but 
a good starting point.

>...
> 		Dave

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

