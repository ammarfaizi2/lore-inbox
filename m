Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751788AbWADPI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbWADPI3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 10:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbWADPI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 10:08:29 -0500
Received: from rtr.ca ([64.26.128.89]:56455 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751792AbWADPI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 10:08:28 -0500
Message-ID: <43BBE4E4.6090900@rtr.ca>
Date: Wed, 04 Jan 2006 10:08:20 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: Sebastian <sebastian_ml@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: Digital Audio Extraction with ATAPI drives far from perfect
References: <20060103222044.GA17682@section_eight.mops.rwth-aachen.de> <20060104092058.GN3472@suse.de> <20060104092443.GO3472@suse.de>
In-Reply-To: <20060104092443.GO3472@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
...
> Oh, and try and disable DMA on the cd driver and repeat your results
> with ide-cd. It uses DMA, where ide-scsi does not.

Eh?  Sure it does!
