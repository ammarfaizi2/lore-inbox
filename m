Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbWAaUpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbWAaUpm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 15:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWAaUpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 15:45:42 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:28531 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751469AbWAaUpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 15:45:42 -0500
Date: Tue, 31 Jan 2006 21:38:45 +0100
From: Jens Axboe <axboe@suse.de>
To: Sander <sander@humilis.net>
Cc: Joshua Kugler <joshua.kugler@uaf.edu>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: [OT] 8-port AHCI SATA Controller?
Message-ID: <20060131203845.GH4215@suse.de>
References: <20060131115343.GA2580@favonius> <200601310919.20199.joshua.kugler@uaf.edu> <20060131185646.GF6178@favonius>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060131185646.GF6178@favonius>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31 2006, Sander wrote:
> > I got the drivers here:
> > 
> > http://www.keffective.com/mvsata/FC3/
> > 
> > The latest was mvSata_Linux_3.6.1.tgz as of 2005-10-13.
> 
> I very, very much prefer in-tree drivers :-)

Actually there is a sata_mv driver in the kernel, however it's pretty
experimental right now. I'm sure it could use testers :-)

-- 
Jens Axboe

