Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269299AbUI3O2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269299AbUI3O2I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 10:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269294AbUI3O2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 10:28:08 -0400
Received: from epia.saillard.org ([213.41.148.43]:45259 "EHLO
	epia.saillard.org") by vger.kernel.org with ESMTP id S269299AbUI3O0J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 10:26:09 -0400
Date: Thu, 30 Sep 2004 16:26:06 +0200
From: Luc Saillard <luc@saillard.org>
To: pinotj@club-internet.fr
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patches for 2.6.9-rc3
Message-ID: <20040930142605.GO21527@epia.localdomain>
References: <2K9Ni-hJ-7@gated-at.bofh.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2K9Ni-hJ-7@gated-at.bofh.it>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 04:10:12PM +0200, pinotj@club-internet.fr wrote:
> Hi,
> 
> Here is some interesting patches for the 2.6.9-rc3:
> http://ngc891.blogdns.net/index.php?2004/09/30/10-kernel-269-rc3-patches 
> 
> Includes pwc/pwcx, cloop and the patched nVidia driver.

For your information, you can found patches for pwc driver for 2.6.9-rc2 that
doesn't support binary interface, but add support for big resolution without
binary code. This add some source code to decompress data from the camera.
Please see http://www.saillard.org/pwc/ for patches.

Note: if you have an old webcam that's not supported by the driver, i'll be
happy to write the decoder part the chipset1.

Luc
