Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131958AbRDPSve>; Mon, 16 Apr 2001 14:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131973AbRDPSvO>; Mon, 16 Apr 2001 14:51:14 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29711 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S131958AbRDPSvF>;
	Mon, 16 Apr 2001 14:51:05 -0400
Date: Mon, 16 Apr 2001 20:50:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: drivers/block/loop.c:max_loop
Message-ID: <20010416205055.L9539@suse.de>
In-Reply-To: <20010416173942.G6934@informatics.muni.cz> <20010416183637.G9539@suse.de> <20010416200012.H6934@informatics.muni.cz> <20010416204437.K9539@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010416204437.K9539@suse.de>; from axboe@suse.de on Mon, Apr 16, 2001 at 08:44:37PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16 2001, Jens Axboe wrote:
> Ok, just noticed that the module option is missing. Attached patch
> should rectify that oversight.

duh, already there of course.

-- 
Jens Axboe

