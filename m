Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271062AbTGPTwW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 15:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271093AbTGPTwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 15:52:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:51171 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S271062AbTGPTwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 15:52:20 -0400
Date: Wed, 16 Jul 2003 22:07:09 +0200
From: Jens Axboe <axboe@suse.de>
To: patrice <patrice.dietsch@free.fr>
Cc: andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: bug report : IDE RW16x10/DVD seems detected by the system but is not present in /dev (devfs)
Message-ID: <20030716200709.GT833@suse.de>
References: <3F15AFA3.9080001@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F15AFA3.9080001@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16 2003, patrice wrote:
> Hi,
> 
> I think I found a bug in the IDE driver. The bug report is following.
> 
> Thank you for help,
> 
> Patrice DIETSCH
> 
> 
> #[1.] One line summary of the problem:
> 
> IDE RW16x10/DVD seems detected by the system but is not present in /dev 
> (devfs)
>
> Linux version 2.4.21-0.13mdk (flepied@bi.mandrakesoft.com) (gcc version 
> 3.2.2 (M
> andrake Linux 9.1 3.2.2-3mdk)) #1 Fri Mar 14 15:08:06 EST 2003

Report this to Mandrake, bug reports for vendor kernels don't belong
here. Or reproduce with 2.4.21/2.4.22-pre7 and resend.

-- 
Jens Axboe

