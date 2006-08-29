Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbWH2M3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWH2M3B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 08:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWH2M25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 08:28:57 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:32477 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751440AbWH2M24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 08:28:56 -0400
Subject: Re: [PATCH] HPA resume fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: Lee Trager <Lee@PicturesInMotion.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       bzolnier@gmail.com
In-Reply-To: <20060829114210.GI12257@kernel.dk>
References: <44F40F06.4010408@PicturesInMotion.net>
	 <1156849911.6271.101.camel@localhost.localdomain>
	 <20060829114210.GI12257@kernel.dk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 29 Aug 2006 13:50:27 +0100
Message-Id: <1156855828.6271.106.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-08-29 am 13:42 +0200, ysgrifennodd Jens Axboe:
> On Tue, Aug 29 2006, Alan Cox wrote:
> > For -mm only to get more testing
> > 
> > Acked-by: Alan Cox <alan@redhat.com>
> 
> It should go into the state machine as described imho. Bart?

If it works then yes it can become an explicit state. Firstly we need to
find out if it works.

