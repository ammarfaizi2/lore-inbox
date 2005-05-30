Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbVE3APc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVE3APc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 20:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVE3APc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 20:15:32 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7952 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261476AbVE3APS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 20:15:18 -0400
Date: Mon, 30 May 2005 02:15:14 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: IMPI doesn't build as modules with 2.6.12-rc5.
Message-ID: <20050530001514.GI10441@stusta.de>
References: <1117410309.12243.66.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117410309.12243.66.camel@localhost>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2005 at 09:45:09AM +1000, Nigel Cunningham wrote:

> Hi all.

Hi Nigel,

> I get a build failure making modules in 2.6.12-rc5. It occurs in
> drivers/char/ipmi/impi_devintf.c, and is related to recent changes to
> class_simple_*.

that's a known bug already fixed in -mm.

> Regards,
> 
> Nigel

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

