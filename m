Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264646AbUEMUry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264646AbUEMUry (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 16:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264737AbUEMUry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 16:47:54 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:51422 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264646AbUEMUrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 16:47:51 -0400
Date: Thu, 13 May 2004 22:47:43 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-mm2
Message-ID: <20040513204743.GH22202@fs.tum.de>
References: <39780000.1084475697@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39780000.1084475697@flay>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 12:14:57PM -0700, Martin J. Bligh wrote:

> 2.6.6-mm2 won't compile without CONFIG_MODULE_UNLOAD ... looks very much
> like the first definition of add_attribute needs moving inside the ifdef.
>...

  http://www.ussg.iu.edu/hypermail/linux/kernel/0405.1/1222.html

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

