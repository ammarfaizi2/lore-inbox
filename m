Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263779AbTDXRTL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 13:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263781AbTDXRTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 13:19:11 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:4839 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263779AbTDXRTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 13:19:10 -0400
Date: Thu, 24 Apr 2003 19:31:22 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.68 fix mismatched access_ok() checks in sg_io()
Message-ID: <20030424173122.GS8775@suse.de>
References: <20030424082331.GE8775@suse.de> <Pine.SOL.4.30.0304241742060.19564-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0304241742060.19564-100000@mion.elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24 2003, Bartlomiej Zolnierkiewicz wrote:
> 
> I've found this while doing bio_map_user() changes,
> please forward to Linus.

Oh yes you are right, I'll fold that in with the changes. Thanks!

-- 
Jens Axboe

