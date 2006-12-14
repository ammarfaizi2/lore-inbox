Return-Path: <linux-kernel-owner+w=401wt.eu-S1751677AbWLNHUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbWLNHUJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 02:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbWLNHUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 02:20:09 -0500
Received: from brick.kernel.dk ([62.242.22.158]:11024 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751677AbWLNHUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 02:20:07 -0500
Date: Thu, 14 Dec 2006 08:21:29 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Mike Christie <michaelc@cs.wisc.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Regression in v2.6.19-git18: Unable to write CD
Message-ID: <20061214072129.GW4576@kernel.dk>
References: <4580DD6F.8060907@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4580DD6F.8060907@lwfinger.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13 2006, Larry Finger wrote:
> There is a regression in v2.6.19-rc18 that makes one unable to write CD's. 
> In k3b, the drive status shows no devices. I used git bisect to find the 
> bad commit is the following:

Try a newer snapshot, it was fixed a few days ago.

-- 
Jens Axboe

