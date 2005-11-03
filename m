Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030341AbVKCPss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030341AbVKCPss (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbVKCPss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:48:48 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:36437 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030341AbVKCPsr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:48:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EUp+6dGsNf+RfLThO24DHV8YMn83XE/pqBzuhtdiElAJFivg2Nh5fgXuCMZyr1bAloIYnc+dCXb1i9MPQDF9kBCELIBMMHJQHTWnKx49sy2Fffr/KVAVfcXG6yptUH/taPMv3ZU/O5Ebwv2cz3/2eJZW/zcFlZ23wFnQ4pDhi20=
Message-ID: <58cb370e0511030748r1cd78522o6b33d68df5a77098@mail.gmail.com>
Date: Thu, 3 Nov 2005 16:48:45 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: Parallel ATA with libata status with the patches I'm working on
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20051103.072810.129576574.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1131029686.18848.48.camel@localhost.localdomain>
	 <20051103144830.GF28038@flint.arm.linux.org.uk>
	 <58cb370e0511030702hb06a5f3qc2dfe465ee1d784c@mail.gmail.com>
	 <20051103.072810.129576574.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/05, David S. Miller <davem@davemloft.net> wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Date: Thu, 3 Nov 2005 16:02:45 +0100
>
> > IMO porting/rewriting host-drivers to libata now is just
> > counter-productive waste of time...
>
> This would be an interesting opinion if you were asked for it.
> But you were not, yet you keep stating it, therefore you must
> feel threatened in some way.

I'm worried about crap being pushed into libata, that's all.

Besides does current situation of ALSA and OSS bring any bells?

> I have to admit that your handling of Alan's desire to do this work
> makes you look very non-transparent as the IDE layer maintainer.

By reading linux-ide ML you will see that actually
I help in development of libata PATA support.

> What do you care if Alan converts all the drivers with his own time
> and effort?  If it's a waste of time, it's his time, which he can

Are you familiar with background discussions before Alan started
this work?  Never explained FUD about current state of drivers/ide,
personal attacks and replying to eny post relating to IDE with either
FUD or "IDE driver is going away"...

Alan plays dirty game and don't say me that this doesn't influnce
my work...

> spend in any way he so chooses.  You've already stated that you think
> it's a waste of time on at least 2 or 3 occaisions, so I think he and
> everyone else gets your point and you don't need to restate this over
> and over again.

OK, I'll shut up now.

Bartlomiej (no more mr nice guy)
