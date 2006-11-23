Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757339AbWKWKWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757339AbWKWKWS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 05:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757341AbWKWKWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 05:22:18 -0500
Received: from nz-out-0102.google.com ([64.233.162.200]:50741 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1757339AbWKWKWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 05:22:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hXs3Bspnp5kWfDAcCjYcwKOonEK92eVKabWLH9AAh85OpTJvnVLkwNEvRZtQlLkdfWBbchQGtp0ZqVy7JZq2c1FGFzR3zLNj5Itr6l4MhX0EihRf0Gab8BusPrv2rWHQ27SDfNjFl8BR2w+VU6t9/vEfr7M7w+EsjAKq57ceeG8=
Message-ID: <9a8748490611230222v5b718d18ne01d913463734437@mail.gmail.com>
Date: Thu, 23 Nov 2006 11:22:16 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Jens Axboe" <jens.axboe@oracle.com>
Subject: Re: Simple script that locks up my box with recent kernels
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <9a8748490611220304y5fc1b90ande7aec9a2e2b4997@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0610071408220.3952@g5.osdl.org>
	 <Pine.LNX.4.64.0610161554140.3962@g5.osdl.org>
	 <9a8748490610161613y7c314e64rfdfafb4046a33a02@mail.gmail.com>
	 <9a8748490610231330y65f3e243pe1101d11a28dbbfa@mail.gmail.com>
	 <9a8748490611211646o2c92564dmfe8d6ffdf66228ba@mail.gmail.com>
	 <Pine.LNX.4.64.0611211827590.3338@woody.osdl.org>
	 <20061122080312.GL8055@kernel.dk>
	 <9a8748490611220255v53bc667y74b05e2b69281f25@mail.gmail.com>
	 <20061122105703.GZ8055@kernel.dk>
	 <9a8748490611220304y5fc1b90ande7aec9a2e2b4997@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 22/11/06, Jens Axboe <jens.axboe@oracle.com> wrote:
...
> > Can you post a full dmesg too, as well as clarify which device holds the
> > swap space?
> >
> Sure. I'll post a full dmesg as soon as I get home.
>

I didn't have time to look at this last night, so I have to keep you
guys waiting for a little while longer.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
