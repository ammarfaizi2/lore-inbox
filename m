Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264377AbUIOKsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUIOKsz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 06:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264668AbUIOKsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 06:48:55 -0400
Received: from sd291.sivit.org ([194.146.225.122]:463 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S264377AbUIOKsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 06:48:54 -0400
Date: Wed, 15 Sep 2004 12:48:52 +0200
From: Stelian Pop <stelian@popies.net>
To: Linux USB List <linux-usb-devel@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>
Cc: Luc Saillard <luc@saillard.org>
Subject: PWC driver now fully GPL [was Re: [PATCH] PWC driver without binary interface]
Message-ID: <20040915104852.GB21917@sd291.sivit.org>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux USB List <linux-usb-devel@lists.sourceforge.net>,
	LKML <linux-kernel@vger.kernel.org>, Luc Saillard <luc@saillard.org>
References: <20040914153918.GA7975@sd291.sivit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914153918.GA7975@sd291.sivit.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 05:39:18PM +0200, Luc Saillard wrote:

> Hi,
> 
>  I've made a patch to (re)add pwc philips driver into the kernel. This driver
> have support for some compression mode (for chipset 2 & 3), so you don't
> need the binary module to grab an image in 640x480@10fps.
[...]
>  The patch is 300kbytes long, i don't include it in this mail. You can found
>  a tarball or a patch against the last linux kernel at:
>     http://www.saillard.org/pwc/linux-2.6.9-rc2_pwc-9.0.2-fork0.2.diff.bz2
>     http://www.saillard.org/pwc/

Just in case nobody payed attention to the original message and 
failed to see that almost all the binary pwcx has been succesfully
reverse-engineered...

Unless everybody is just waiting for the next flamewar...

Good job Luc !

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
