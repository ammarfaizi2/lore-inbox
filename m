Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbTEESD0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 14:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbTEESDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 14:03:25 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:43915 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261178AbTEESDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 14:03:24 -0400
Date: Mon, 5 May 2003 13:50:16 -0400
From: Ben Collins <bcollins@debian.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 658] New: compile failure in drivers/video/aty/mach64_gx.c
Message-ID: <20030505175016.GR679@phunnypharm.org>
References: <10680000.1052152655@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10680000.1052152655@[10.10.2.4]>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 09:37:35AM -0700, Martin J. Bligh wrote:
> http://bugme.osdl.org/show_bug.cgi?id=658
> 
>            Summary: compile failure in drivers/video/aty/mach64_gx.c
>     Kernel Version: 2.5.68-bk11
>             Status: NEW
>           Severity: low
>              Owner: jsimmons@infradead.org
>          Submitter: john@larvalstage.com
> 
> 
> Distribution:  Gentoo 1.4rc4
> Hardware Environment:  Abit KG7-RAID, AMD AthlonXP 2100+ Palomino
> Software Environment:  gcc 3.2.2, glibc 2.3.1, ld 2.13.90.0.18
> Problem Description:

This is fixed in 2.5.69, with a patch that reverted all of video/aty to
2.5.68-stock.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
