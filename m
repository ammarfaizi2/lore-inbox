Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbTJJBzN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 21:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbTJJBzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 21:55:13 -0400
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:53150 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S262718AbTJJBzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 21:55:10 -0400
Date: Thu, 9 Oct 2003 21:40:28 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Maciej Zenczykowski <maze@cela.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Query: PNP BIOS for 2.4.22
Message-ID: <20031009214028.GA12073@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Maciej Zenczykowski <maze@cela.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0310100325090.1794-100000@gaia.cela.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310100325090.1794-100000@gaia.cela.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 03:30:09AM +0200, Maciej Zenczykowski wrote:
> I'm searching for the/a PNP BIOS patch for 2.4.22 (or 2.4.23pre6) or any
> recent 2.4 kernel.  It's included in the 2.4.22-ac series, however that's
> with a whole lot of other 'cruft' - and I'd prefer a minimal clean
> version.  I'm in the process of cutting it out of the ac patch - however
> I'm worried I might miss something (some non-obvious dependancy).  I can't
> seem to find any sources/patches on the (apparent) home page of the
> project...
>
> Thanks,
> 
> MaZe.
> 

To my knowledge, the ac series has the only up to date pnpbios patch for 2.4.
You may, however, want to try the latest 2.6-test kernel which ships with an
improved pnpbios driver.  Is there a particular PnPBIOS feature you are looking
for in 2.4?  In other words which PnPBIOS services interest you?

Thanks,
Adam
