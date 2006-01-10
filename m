Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWAJOMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWAJOMu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 09:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWAJOMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 09:12:49 -0500
Received: from rtr.ca ([64.26.128.89]:27299 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932075AbWAJOMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 09:12:49 -0500
Message-ID: <43C3C0B8.30205@rtr.ca>
Date: Tue, 10 Jan 2006 09:12:08 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2G memory split
References: <20060110125852.GA3389@suse.de>
In-Reply-To: <20060110125852.GA3389@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
..
> +choice
> +	depends on NOHIGHMEM

Is that dependency strictly needed here?

(Mark hurriedly applies patch and rebuilds kernel on 2G notebook..)

Cheers!
