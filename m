Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262184AbVFHLhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbVFHLhY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 07:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbVFHLhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 07:37:22 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:21485 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S262177AbVFHLgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 07:36:37 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH] SATA NCQ #4
Date: Wed, 08 Jun 2005 21:36:24 +1000
Organization: <http://scatter.mine.nu/>
Message-ID: <qrjda1h0sbohfdi5t57rqpp581avqcslir@4ax.com>
References: <20050608102857.GC18490@suse.de>
In-Reply-To: <20050608102857.GC18490@suse.de>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,
On Wed, 8 Jun 2005 12:28:59 +0200, Jens Axboe <axboe@suse.de> wrote:
>
>This should be pretty final, at least only minor stuff left. Changes:

Fell over here, on http://scatter.mine.nu/test/boxen/sempro/

No logged info, just scrolling heaps junk on screen --> libata 
I could see and I think 8 digit hex in [] on left.  

Hit RESET to reboot, no apparent filesystem damage :)  Sorry so 
little info.  patched 2.6.12-rc6 cleanly  seemed to go stupid 
during mount reiserfs partitions, about that stage of boot.

Being a sucker for punishment, I recompiled with 8KB stacks, highmem 
off (box has 1GB mem) and it go stupid when touch HDD, but USB started 
okay while it stupid, saw USB messages and mouse lit up.

Hit RESET to reboot...  Again, box safely back in 2.6.11.11 land :)

--Grant.

