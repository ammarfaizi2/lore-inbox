Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263666AbTKKTlg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 14:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263698AbTKKTlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 14:41:36 -0500
Received: from mail4-141.ewetel.de ([212.6.122.141]:8699 "EHLO mail4.ewetel.de")
	by vger.kernel.org with ESMTP id S263666AbTKKTlf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 14:41:35 -0500
Date: Tue, 11 Nov 2003 20:41:24 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <Pine.LNX.4.44.0311110950250.30657-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0311112039110.1448-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Nov 2003, Linus Torvalds wrote:

> Can you try just writing to the thing as a raw device, ie simply doing 
> something like
[...]

Will do and report on what I find.

>> I didn't see problems with using ide-scsi/sd for that drive in 2.5.7x,
>> by the way, so I'm not so sure ide-scsi is really broken for that
>> purpose.
> It would be interesting to hear if ide-scsi works. 

I'll check on that, too.

-- 
Ciao,
Pascal

