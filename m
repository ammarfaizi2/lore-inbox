Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbULDJq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbULDJq2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 04:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbULDJq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 04:46:27 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:38861 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261391AbULDJqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 04:46:25 -0500
Date: Sat, 4 Dec 2004 10:45:55 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-ac13
Message-ID: <20041204094551.GA10449@suse.de>
References: <1102096309.10714.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102096309.10714.1.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03 2004, Alan Cox wrote:
> o	Teach ide-cd to use sense data for file system	(Alan Cox)
> 	requests
> 	- This means you get better diagonstics on CD errors
> 	- It means a partial I/O failure will get you back the ok sectors
> 	- It may fix the problem some users have with ISO copying and ide-cd

That's a good idea and definitely lots of room for improvement there. So
I went to take a look at it, but it doesn't seem to be apart of
2.6.9-ac13?

-- 
Jens Axboe

