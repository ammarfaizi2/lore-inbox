Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbWF1RRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWF1RRz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 13:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWF1RRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 13:17:55 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17669 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751438AbWF1RRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 13:17:53 -0400
Date: Wed, 28 Jun 2006 19:17:51 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] kernel/rcutorture.c: make code static
Message-ID: <20060628171751.GK13915@stusta.de>
References: <20060627015211.ce480da6.akpm@osdl.org> <20060628165445.GQ13915@stusta.de> <20060628171309.GE1293@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628171309.GE1293@us.ibm.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 10:13:09AM -0700, Paul E. McKenney wrote:
> On Wed, Jun 28, 2006 at 06:54:45PM +0200, Adrian Bunk wrote:
> > This patch makes needlessly global code static.
> 
> Looks good to me -- but have you tested it?  If so, I will ack, otherwise
> I will test and ack/nack depending on the results.

I've only tested the compilation (which should be enough considering the 
nature of the patch).

> 							Thanx, Paul

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

