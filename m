Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262040AbSKCOfr>; Sun, 3 Nov 2002 09:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262042AbSKCOfr>; Sun, 3 Nov 2002 09:35:47 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:22469 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S262040AbSKCOfq>; Sun, 3 Nov 2002 09:35:46 -0500
Date: Sun, 3 Nov 2002 15:42:17 +0100
From: Luc Saillard <luc.saillard@fr.alcove.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops when using ide-cd with 2.5.45 and cdrecord
Message-ID: <20021103144217.GA9008@cedar.alcove-fr>
References: <20021102210103.GA25617@cedar.alcove-fr> <20021102213448.GA3612@suse.de> <20021103002346.GA25842@cedar.alcove-fr> <20021103094052.GI3612@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021103094052.GI3612@suse.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 10:40:52AM +0100, Jens Axboe wrote:
 
> please reproduce with this debug patch and send me the output:
> 
 
I've no problem with your patch. I've burn 5 cds without problems.

Here my ouput for a record:
hdc: 5a, ptr=cf3a7c00,len=2,bio=00000000
hdc: 5a, ptr=cf457e00,len=2,bio=00000000
hdc: 5a, ptr=cf457e00,len=2,bio=00000000
hdc: 5a, ptr=cf457e00,len=2,bio=00000000
hdc: 5a, ptr=cf457e00,len=2,bio=00000000
hdc: 5a, ptr=cf457e00,len=2,bio=00000000
hdc: 5a, ptr=cf457e00,len=2,bio=00000000
hdc: 5a, ptr=cf457e00,len=2,bio=00000000
hdc: 5a, ptr=cf457e00,len=2,bio=00000000
hdc: 5a, ptr=cf457e00,len=2,bio=00000000
hdc: 5a, ptr=cf457e00,len=2,bio=00000000
hdc: 5a, ptr=cf457e00,len=2,bio=00000000
hdc: 5a, ptr=cf457e00,len=2,bio=00000000
hdc: 5a, ptr=cf457e00,len=2,bio=00000000
hdc: 51, ptr=cf457e00,len=34,bio=00000000
hdc: 51, ptr=cf457e00,len=34,bio=00000000
hdc: 5a, ptr=cf457e00,len=2,bio=00000000
hdc: 5a, ptr=cf457e00,len=2,bio=00000000
hdc: 5a, ptr=cf457e00,len=2,bio=00000000
hdc: 5a, ptr=cf457e00,len=2,bio=00000000
hdc: 5a, ptr=cf457e00,len=2,bio=00000000
hdc: 5a, ptr=cf457e00,len=2,bio=00000000
hdc: 5a, ptr=cf457e00,len=2,bio=00000000
hdc: 5a, ptr=cf457c00,len=2,bio=00000000
hdc: 5a, ptr=cf457c00,len=2,bio=00000000
hdc: 5a, ptr=cf457c00,len=2,bio=00000000
hdc: 5a, ptr=cf457c00,len=2,bio=00000000
hdc: 5a, ptr=d0d5f200,len=2,bio=00000000

Luc
