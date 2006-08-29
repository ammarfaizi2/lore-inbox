Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965329AbWH2UyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965329AbWH2UyV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 16:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965331AbWH2UyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 16:54:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:61660 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965329AbWH2UyT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 16:54:19 -0400
Date: Tue, 29 Aug 2006 13:52:50 -0700
From: Greg KH <greg@kroah.com>
To: David Lang <dlang@digitalinsight.com>
Cc: Olaf Hering <olaf@aepfle.de>, Michael Buesch <mb@bu3sch.de>,
       Oleg Verych <olecom@flower.upol.cz>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Sven Luther <sven.luther@wanadoo.fr>, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
Message-ID: <20060829205250.GA14508@kroah.com>
References: <1156802900.3465.30.camel@mulgrave.il.steeleye.com> <Pine.LNX.4.63.0608290844240.30381@qynat.qvtvafvgr.pbz> <20060829183208.GA11468@kroah.com> <200608292104.24645.mb@bu3sch.de> <20060829201314.GA28680@aepfle.de> <Pine.LNX.4.63.0608291341060.30381@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0608291341060.30381@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2006 at 01:42:56PM -0700, David Lang wrote:
> 
> besides, several kernel versions ago this used to work. the current 
> requirement is a regression as far as the user is concerned.

Then go bug the driver authors please :)

thanks,

greg k-h
