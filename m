Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272261AbTGYTUy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 15:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272263AbTGYTUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 15:20:39 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:9602
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S272261AbTGYTUi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 15:20:38 -0400
Date: Fri, 25 Jul 2003 15:35:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Erik Steffl <steffl@bigfoot.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SATA (Serial ATA) support in 2.4.x?
Message-ID: <20030725193548.GA14017@gtf.org>
References: <3F217BE8.5070807@bigfoot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F217BE8.5070807@bigfoot.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 25, 2003 at 11:50:16AM -0700, Erik Steffl wrote:
>   I am specifically interested whether it should support disks above 
> 137GB (as I have problems accessing anything above 137GB on 250GB SATA 
> drive)

It should.

I will be testing this when I return from OLS, next week.

	Jeff



