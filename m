Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbUCHULM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 15:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbUCHULM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 15:11:12 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:44720 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261170AbUCHUKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 15:10:53 -0500
Date: Mon, 8 Mar 2004 21:10:49 +0100
From: Jens Axboe <axboe@suse.de>
To: Balram Adlakha <balram_a@ftml.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-rc2-mm1
Message-ID: <20040308201049.GK23525@suse.de>
References: <20040308174109.GA784@balram.gotdns.org> <20040308194749.GJ23525@suse.de> <20040308195600.GA3155@balram.gotdns.org> <20040308200639.GA3397@balram.gotdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040308200639.GA3397@balram.gotdns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09 2004, Balram Adlakha wrote:
> I can't figure out why my ripping speed is so slow though, I'm getting
> a 3x speed with paranoia, around 6x without jitter correction. Any
> ideas where the problem might be?

Probably the drive, not all drives are happy with reading cdda really
fast...

-- 
Jens Axboe

