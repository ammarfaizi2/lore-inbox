Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTENHd7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 03:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbTENHd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 03:33:59 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:31118 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262196AbTENHd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 03:33:58 -0400
Date: Wed, 14 May 2003 09:46:26 +0200
From: Jens Axboe <axboe@suse.de>
To: fab@tlen.pl
Cc: linux-kernel@vger.kernel.org, petero2@telia.com
Subject: Re: Mount Rainier and kernel 2.6
Message-ID: <20030514074626.GA17033@suse.de>
References: <20030514063216.2018C6EE92@rekin4.o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030514063216.2018C6EE92@rekin4.o2.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14 2003, fab@tlen.pl wrote:
> I would like to ask if support for Mount Rainier is inluded in 2.6 
> kernel (as it was written in artice info on page 
> http://kt.zork.net/kernel-traffic/kt20021021_189.html#3)

No it isn't, at least not yet. As it just happens, my mt rainier drive
is mounted in the 2.5 testbox though. If I get the time, I don't see any
reason it can't make it into 2.6. It's a pretty simple addition now,
ide-cd has write support etc.

-- 
Jens Axboe

