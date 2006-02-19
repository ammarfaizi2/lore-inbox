Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWBSR7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWBSR7A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 12:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWBSR7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 12:59:00 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:3760 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S932186AbWBSR7A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 12:59:00 -0500
Date: Sun, 19 Feb 2006 09:58:41 -0800
From: Greg KH <greg@kroah.com>
To: Chris Boot <bootc@bootc.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Driver 'w83627hf' needs updating - please use bus_type methods
Message-ID: <20060219175841.GC2674@kroah.com>
References: <0BF2E785-CC6D-4E4D-BDCF-AD21AEA10D36@bootc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0BF2E785-CC6D-4E4D-BDCF-AD21AEA10D36@bootc.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 10:56:25AM +0000, Chris Boot wrote:
> Hi all,
> 
> Just noticed the above message in my kernel log on my machine running  
> 2.6.16-rc2-ide2. I know there's a 2.6.16-rc4 now... I'm waiting to  
> upgrade until Alan comes up with new -ide patches or ATAPI over  
> libata/PATA starts working in -mm.

Should be fixed in -rc4.  If not, please let us know.

thanks,

greg k-h
