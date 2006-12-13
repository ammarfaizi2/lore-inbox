Return-Path: <linux-kernel-owner+w=401wt.eu-S932665AbWLMLMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932665AbWLMLMX (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 06:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932671AbWLMLMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 06:12:22 -0500
Received: from lazybastard.de ([212.112.238.170]:45518 "EHLO
	longford.lazybastard.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932665AbWLMLMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 06:12:19 -0500
X-Greylist: delayed 2312 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 06:12:19 EST
Date: Wed, 13 Dec 2006 07:06:06 +0000
From: =?utf-8?B?SsO2cm4=?= Engel <joern@lazybastard.org>
To: Josh Boyer <jwboyer@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, jffs-dev@axis.com,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH/RFC] Delete JFFS (version 1)
Message-ID: <20061213070605.GB19825@lazybastard.org>
References: <457EA2FE.3050206@garzik.org> <20061212095359.51483704.akpm@osdl.org> <625fc13d0612121038l22a2b252v3d3773caa8826e41@mail.gmail.com> <20061212214904.GR5937@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061212214904.GR5937@schatzie.adilger.int>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 December 2006 14:49:04 -0700, Andreas Dilger wrote:
> 
> It would be better to have a printk in the module init, since users with
> upstream builds won't see the config help.

How many of those are there?  This is not ext3, this is a flash
filesystem.  Users are either those doing the upstream build or they
won't ever see a console.  Think DSL-Router. ;)

Jörn

-- 
Joern's library part 14:
http://www.sandpile.org/
