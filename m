Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283804AbRK3VeH>; Fri, 30 Nov 2001 16:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283805AbRK3Vd6>; Fri, 30 Nov 2001 16:33:58 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:33806 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283804AbRK3Vdr>;
	Fri, 30 Nov 2001 16:33:47 -0500
Date: Fri, 30 Nov 2001 22:33:24 +0100
From: Jens Axboe <axboe@suse.de>
To: Gertjan van Wingerde <gwingerde@home.nl>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Compile fixes for 2.5.1-pre4
Message-ID: <20011130223324.G25987@suse.de>
In-Reply-To: <3C07D770.3010807@home.nl> <20011130201231.G22698@suse.de> <3C07DD68.30707@home.nl> <20011130203155.A25987@suse.de> <3C07E4B7.1060109@home.nl> <20011130205820.D25987@suse.de> <3C07FACD.6010903@home.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C07FACD.6010903@home.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30 2001, Gertjan van Wingerde wrote:
> I've tested the linear and RAID-0 code in my own environment. The code
> survived some basic tests (starting, reading/writing, etc.) and some
> heavy-duty read-write tests.

Excellent, thanks a lot. Applied.

-- 
Jens Axboe

