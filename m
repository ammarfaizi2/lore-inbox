Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262913AbSKAIrK>; Fri, 1 Nov 2002 03:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265335AbSKAIrJ>; Fri, 1 Nov 2002 03:47:09 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:41891 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262913AbSKAIp5>;
	Fri, 1 Nov 2002 03:45:57 -0500
Date: Fri, 1 Nov 2002 09:52:15 +0100
From: Jens Axboe <axboe@suse.de>
To: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.45: IDE as modules - unresolved symbols
Message-ID: <20021101085215.GH807@suse.de>
References: <200211010433.07804.Dieter.Nuetzel@hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200211010433.07804.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01 2002, Dieter Nützel wrote:
> depmod: *** Unresolved symbols in 
> /lib/modules/2.5.45/kernel/drivers/ide/ide-disk.o
> depmod:         proc_ide_read_geometry

Please stop reporting this again and again. We know it's broken, we
don't really care right now, its on several of the '2.5 status' lists.
Either fix it yourself and post a patch, or watch the changelogs for
anything which might say this has been solved.

-- 
Jens Axboe

