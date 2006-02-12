Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWBLCEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWBLCEL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 21:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWBLCEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 21:04:11 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:12766 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932189AbWBLCEJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 21:04:09 -0500
Subject: Re: [2.6 patch] update OBSOLETE_OSS_DRIVER schedule and
	dependencies
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060211145050.GA30922@stusta.de>
References: <20060211145050.GA30922@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 12 Feb 2006 02:04:50 +0000
Message-Id: <1139709891.23823.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2006-02-11 at 15:50 +0100, Adrian Bunk wrote:
> This patch updates the schedule for the removal of drivers depending on 
> OBSOLETE_OSS_DRIVER as follows:
> - adjust OBSOLETE_OSS_DRIVER dependencie
> - from the release of 2.6.16 till the release of 2.6.17:
>   approx. two months for users to report problems with the ALSA
>   drivers for the same hardware

Why are you obsessed with doing everything on what are (to end users)
stupidly short time scales. It doesn't matter if OSS takes another year
to finally go away so stop setting silly deadlines.

