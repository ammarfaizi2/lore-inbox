Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbUKQGp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbUKQGp0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 01:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262218AbUKQGpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 01:45:25 -0500
Received: from egg.hpc2n.umu.se ([130.239.45.244]:4261 "EHLO egg.hpc2n.umu.se")
	by vger.kernel.org with ESMTP id S262215AbUKQGoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 01:44:08 -0500
Date: Wed, 17 Nov 2004 07:44:03 +0100
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Ake <Ake.Sandgren@hpc2n.umu.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Slab corruption with 2.6.9 + swsusp2.1
Message-ID: <20041117064403.GB26723@hpc2n.umu.se>
References: <20041116115917.GN4344@hpc2n.umu.se> <1100635759.4362.4.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100635759.4362.4.camel@desktop.cunninghams>
User-Agent: Mutt/1.5.6+20040722i
From: Ake.Sandgren@hpc2n.umu.se (Ake)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 07:09:19AM +1100, Nigel Cunningham wrote:
> On Tue, 2004-11-16 at 22:59, Ake wrote:
> > I got a slab corruption message running 2.6.9 + swsusp2.1 and
> > nvidia_compat.patch + vm-pages_scanned-active_list.patch from -ck3.
> 
> Just so I'm clear, why do you think it's suspending that's causing the
> corruption?

I don't. I was just making clear exactly what kernel source i was using.

It probably haven't got anything to do with the swsusp code, but since
those patches are applied i though i better let you know.

The machine was basically doing nothing since i was out for lunch.
X was running screensaver and it was playing some mp3's.

-- 
Ake Sandgren, HPC2N, Umea University, S-90187 Umea, Sweden
Internet: ake@hpc2n.umu.se	Phone: +46 90 7866134 Fax: +46 90 7866126
Mobile: +46 70 7716134 WWW: http://www.hpc2n.umu.se
