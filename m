Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129423AbQLFJje>; Wed, 6 Dec 2000 04:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131212AbQLFJjY>; Wed, 6 Dec 2000 04:39:24 -0500
Received: from [213.237.20.108] ([213.237.20.108]:24365 "EHLO ns.geekboy.dk")
	by vger.kernel.org with ESMTP id <S131202AbQLFJjK>;
	Wed, 6 Dec 2000 04:39:10 -0500
Date: Tue, 5 Dec 2000 22:53:11 +0100
From: Torben Mathiasen <torben@kernel.dk>
To: Borislav Deianov <borislav@ensim.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, tytso@mit.edu
Subject: Re: SCSI Oops (was test12-pre4)
Message-ID: <20001205225310.A1100@torben>
In-Reply-To: <20001204153527.A5425@aero.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001204153527.A5425@aero.ensim.com>; from borislav@ensim.com on Mon, Dec 04, 2000 at 03:35:28PM -0800
X-OS: Linux 2.4.0-test11-ac4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04 2000, Borislav Deianov wrote:
> (cross-posted to linux-kernel and linux-scsi)
> 
> Hi,
> 
> The SCSI oops I reported last week is still present in test12-pre4.
> This is on a Dell PowerEdge 6300. It has two Adaptec AIC-7890, one
> Adaptec AIC-7860, and an AMI MegaRAID controller. There's nothing on
> the 7890s, a CDROM and a tape drive on the 7890.
> 
> With all of the above enabled the kernel boots with no problems.
> However, if I disable the two 7890s from the BIOS (to save 30 seconds
> of boot time), I get an oops.
> 
> The decoded oops is below. Please email me directly for further
> information.
>

Could you find out exactly when this broke?


-- 
Torben Mathiasen <torben@kernel.dk>
Linux ThunderLAN maintainer 
http://tlan.kernel.dk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
