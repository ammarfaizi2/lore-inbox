Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267947AbUGWUKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267947AbUGWUKY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 16:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267725AbUGWUKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 16:10:24 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:36036 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268001AbUGWUKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 16:10:04 -0400
Date: Fri, 23 Jul 2004 22:09:54 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Kevin Fox <Kevin.Fox@pnl.gov>
Cc: Andrew Morton <akpm@osdl.org>, corbet@lwn.net,
       linux-kernel@vger.kernel.org
Subject: Re: New dev model (was [PATCH] delete devfs)
Message-ID: <20040723200954.GP19329@fs.tum.de>
References: <40FEEEBC.7080104@quark.didntduck.org> <20040721231123.13423.qmail@lwn.net> <20040721235228.GZ14733@fs.tum.de> <20040722025539.5d35c4cb.akpm@osdl.org> <20040722193337.GE19329@fs.tum.de> <20040722160112.177fc07f.akpm@osdl.org> <1090528107.10227.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090528107.10227.4.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2004 at 01:28:27PM -0700, Kevin Fox wrote:

> How is this any different then the old dev model with very short release
> cycles? (Other then keeping a "2." prefixed forever)

Currently, the old stable tree will be supported for several years even 
after the new stable tree opens (2.0 and 2.2 seem to be quite dead today 
and might even miss several security fixes but 2.4 is still 
well-maintained). If you use a 2.4 kernel today you know that you can 
follow 2.4 for the next year without risking big breakages.

With the new dev model, I assume noone will maintain a 2.6.8 tree for 
several years.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

