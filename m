Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292287AbSBBOnt>; Sat, 2 Feb 2002 09:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292288AbSBBOnj>; Sat, 2 Feb 2002 09:43:39 -0500
Received: from mustard.heime.net ([194.234.65.222]:5292 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S292287AbSBBOnZ>; Sat, 2 Feb 2002 09:43:25 -0500
Date: Sat, 2 Feb 2002 15:43:03 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Roger Larsson <roger.larsson@norran.net>
cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@zip.com.au>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Errors in the VM - detailed
In-Reply-To: <200202011847.g11Ilwa14845@maila.telia.com>
Message-ID: <Pine.LNX.4.30.0202021540190.10436-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm.. suppose this is the problem anyway and that Jens patch was not enough.
> How do the disk drive sound during the test?

The disk is SILENT! I can hardly hear anything.

> Does it start to sound more when performance goes down?

I don't beleive it's a seek problem, as the readahead (RAID chunk size) is
1MB

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

