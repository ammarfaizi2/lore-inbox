Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbTEFPCr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 11:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263781AbTEFPCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 11:02:47 -0400
Received: from mail2.ewetel.de ([212.6.122.18]:23769 "EHLO mail2.ewetel.de")
	by vger.kernel.org with ESMTP id S263777AbTEFPCq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 11:02:46 -0400
Date: Tue, 6 May 2003 17:15:12 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: Jens Axboe <axboe@suse.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [IDE] trying to make MO drive work with ide-floppy/ide-cd
In-Reply-To: <20030506141153.GB25901@suse.de>
Message-ID: <Pine.LNX.4.44.0305061714290.965-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 May 2003, Jens Axboe wrote:

>> Could we please have this patch included in the 2.4 IDE code to make
>> MO drives and CD writers behave the same?
> Not until you fix ide-cd to correctly identify it. This half-assed
> solution wont do.

Okay. There's no problem using ide-scsi and sd for the MO drive
on 2.4.

-- 
Ciao,
Pascal

