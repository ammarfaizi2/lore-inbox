Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268121AbUH1XNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268121AbUH1XNR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 19:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268126AbUH1XNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 19:13:16 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:9669 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268121AbUH1XNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 19:13:11 -0400
Date: Sun, 29 Aug 2004 01:13:03 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [2.4 patch][1/6] lmc_media.c: fix gcc 3.4 compilation
Message-ID: <20040828231303.GN12772@fs.tum.de>
References: <20040826195133.GB12772@fs.tum.de> <20040826195643.GD12772@fs.tum.de> <41310E26.1050006@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41310E26.1050006@pobox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 06:58:46PM -0400, Jeff Garzik wrote:

> I only got patches 1/6 and 6/6... was that intentional?

Yes, I only sent you an explicit Cc of the patches that affected net 
drivers (but you should have gotten all six via linux-kernel).

cu
Adrian

BTW: Marcelo has already merged all six patches.

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

