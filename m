Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbWB0OkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWB0OkK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 09:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWB0OkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 09:40:10 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:55870 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751284AbWB0OkJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 09:40:09 -0500
Date: Mon, 27 Feb 2006 15:28:26 +0100
From: Jens Axboe <axboe@suse.de>
To: Andy Chittenden <AChittenden@bluearc.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Andrew Morton <akpm@osdl.org>,
       davej@redhat.com, linux-kernel@vger.kernel.org, lwoodman@redhat.com
Subject: Re: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Message-ID: <20060227142825.GB24981@suse.de>
References: <89E85E0168AD994693B574C80EDB9C270393BF0E@uk-email.terastack.bluearc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89E85E0168AD994693B574C80EDB9C270393BF0E@uk-email.terastack.bluearc.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27 2006, Andy Chittenden wrote:
> Jens,
> 
> It looks like my message containing the updated dmesg output didn't make
> it out (well it's not in the lkml archives anyway (that I could see!)).
> Anyway, here's the output from dmesg one more time. Hope it helps you
> diagnose/fix this problem:

Any chance you can try the patch Andi posted to fix the bounce setup on
64-bti machines? Should fix your case, I think. Let me know if you
missed it, and I'll dig out the link again.

-- 
Jens Axboe

