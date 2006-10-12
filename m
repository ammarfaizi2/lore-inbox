Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161240AbWJLGxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161240AbWJLGxj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 02:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161285AbWJLGxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 02:53:38 -0400
Received: from brick.kernel.dk ([62.242.22.158]:59418 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1161240AbWJLGxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 02:53:38 -0400
Date: Thu, 12 Oct 2006 08:53:47 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Alex Romosan <romosan@sycorax.lbl.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1 regression: unable to read dvd's
Message-ID: <20061012065346.GY6515@kernel.dk>
References: <87hcya8fxk.fsf@sycorax.lbl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87hcya8fxk.fsf@sycorax.lbl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11 2006, Alex Romosan wrote:
> i am not able to read movie dvd's anymore under 2.6.19-rc1. i get the
> following in the syslog:
> 
>   kernel: hdc: read_intr: Drive wants to transfer data the wrong way!
> 
> the drive in question is on a thinkpad t40:
> 
>   kernel: hdc: UJDA745 DVD/CDRW, ATAPI CD/DVD-ROM drive
>   kernel: hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
> 
> i can read the disks under 2.6.18 so it's probably not the drive's
> fault. any ideas?

Test case, please.

-- 
Jens Axboe

