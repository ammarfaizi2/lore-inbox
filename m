Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVHCGl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVHCGl5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 02:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVHCGl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 02:41:57 -0400
Received: from edu.joroinen.fi ([194.89.68.130]:16310 "EHLO edu.joroinen.fi")
	by vger.kernel.org with ESMTP id S261462AbVHCGl4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 02:41:56 -0400
Date: Wed, 3 Aug 2005 09:41:55 +0300
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       "Wichert, Gerhard" <Gerhard.Wichert@fujitsu-siemens.com>
Subject: Re: ahci, SActive flag, and the HD activity LED
Message-ID: <20050803064155.GH2106@edu.joroinen.fi>
References: <42EF93F8.8050601@fujitsu-siemens.com> <20050802163519.GB3710@suse.de> <42F05359.7030006@fujitsu-siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42F05359.7030006@fujitsu-siemens.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2005 at 07:17:13AM +0200, Martin Wilck wrote:
> Jens Axboe wrote:
> 
> >>If I am reading the specs correctly, that'd mean the ahci driver is 
> >>wrong in setting the SActive bit.
> >
> >I completely agree, that was my reading of the spec as well and hence my
> >original posts about this in the NCQ thread.
> 
> Have you (or has anybody else) also seen the wrong behavior of the 
> activity LED?
>

I have a box with ICH6R and AHCI in use with Linux 2.6.11, using seagate NCQ
sata drives. the HD activity LED is on all the time..

- Pasi Kärkkäinen
       
                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.
