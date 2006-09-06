Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030244AbWIFXeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbWIFXeA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030208AbWIFXeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:34:00 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:55300 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030249AbWIFXd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:33:58 -0400
Date: Thu, 7 Sep 2006 01:33:57 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [patch 00/37] -stable review
Message-ID: <20060906233357.GB25473@stusta.de>
References: <20060906225444.GA15922@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 03:54:44PM -0700, Greg KH wrote:
> This is the start of the stable review cycle for next 2.6.17.y release.
> There are 37 patches in this series, all will be posted as a response to
> this one.  If anyone has any issues with these being applied, please let
> us know.  If anyone is a maintainer of the proper subsystem, and wants
> to add a Signed-off-by: line to the patch, please respond with it.
> 
> These patches are sent out with a number of different people on the Cc:
> line.  If you wish to be a reviewer, please email stable@kernel.org to
> add your name to the list.  If you want to be off the reviewer list,
> also email us.
> 
> Responses should be made by Fri Sep 8 22:00:00 UTC.  Anything received
> after that time might be too late.
> 
> Full patch of this whole series is available at:
> 	http://www.kernel.org/pub/linux/kernel/people/gregkh/stable/patch-2.6.17.12-rc1.gz
> if you wish to test it out and make sure nothing is broken on your
> architecture or system.

The patch is reversed and doesn't update the Makefile.

> thanks,
> 
> greg k-h

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

