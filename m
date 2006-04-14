Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbWDNBaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbWDNBaP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 21:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWDNBaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 21:30:15 -0400
Received: from MAIL.13thfloor.at ([212.16.62.50]:39831 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S932438AbWDNBaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 21:30:13 -0400
Date: Fri, 14 Apr 2006 03:30:12 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Jes Sorensen <jes@sgi.com>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com, stern@rowland.harvard.edu, sekharan@us.ibm.com,
       akpm@osdl.org, David Chinner <dgc@sgi.com>
Subject: Re: notifier chain problem? (was Re: 2.6.17-rc1 did break XFS)
Message-ID: <20060414013012.GB11178@MAIL.13thfloor.at>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Jes Sorensen <jes@sgi.com>, Con Kolivas <kernel@kolivas.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>,
	linux-xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
	stern@rowland.harvard.edu, sekharan@us.ibm.com, akpm@osdl.org,
	David Chinner <dgc@sgi.com>
References: <20060413052145.GA31435@MAIL.13thfloor.at> <20060413072325.GF2732@melbourne.sgi.com> <yq0k69tuauh.fsf@jaguar.mkp.net> <20060413135000.GB6663@MAIL.13thfloor.at> <Pine.LNX.4.61.0604131618350.17374@yvahk01.tjqt.qr> <20060413175342.GF6663@MAIL.13thfloor.at> <Pine.LNX.4.61.0604132049110.20938@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0604132049110.20938@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 08:52:05PM +0200, Jan Engelhardt wrote:
> 
> >[    3.583356] hda: QEMU HARDDISK, ATA DISK drive
> >[    5.021521] hdc: QEMU HARDDISK, ATA DISK drive
> 
> Maybe QEMU is involved in the Oops? What if used on a normal system?

well, might be, but a) it works perfectly fine with
2.6.16 and many older kernels, and b) sorry, I don't
have a real system for xfs crash testing right now

find the config in my reply to the previous email

best,
Herbert

> Jan Engelhardt
> -- 
