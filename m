Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287303AbSA2BsY>; Mon, 28 Jan 2002 20:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288411AbSA2BsE>; Mon, 28 Jan 2002 20:48:04 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16402 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288377AbSA2Brx>; Mon, 28 Jan 2002 20:47:53 -0500
Date: Mon, 28 Jan 2002 17:46:49 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
cc: Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>,
        Dave Jones <davej@suse.de>
Subject: Re: [PATCH] scsi uodate to remove io_request_lock
In-Reply-To: <20020129043528.47f020a7.johnpol@2ka.mipt.ru>
Message-ID: <Pine.LNX.4.33.0201281745350.10600-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Jan 2002, Evgeniy Polyakov wrote:
>
> > You still have a bit of work to do :-)
> Yep, done.
>
> So, please check and apply.

Can you re-do the diff against your previous diff, I've already applied it
to my tree..

		Linus

