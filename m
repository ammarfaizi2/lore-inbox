Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130915AbRBGBOC>; Tue, 6 Feb 2001 20:14:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130862AbRBGBNn>; Tue, 6 Feb 2001 20:13:43 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:11026 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130915AbRBGBNd>; Tue, 6 Feb 2001 20:13:33 -0500
Date: Tue, 6 Feb 2001 19:08:23 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        Ben LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010206190823.E23960@vger.timpanogas.org>
In-Reply-To: <20010207003629.M1167@redhat.com> <Pine.LNX.4.10.10102061642330.2045-100000@penguin.transmeta.com> <20010206185115.A23754@vger.timpanogas.org> <20010207020221.B13647@suse.de> <20010206190050.B23960@vger.timpanogas.org> <20010207020853.A14105@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010207020853.A14105@suse.de>; from axboe@suse.de on Wed, Feb 07, 2001 at 02:08:53AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2001 at 02:08:53AM +0100, Jens Axboe wrote:
> On Tue, Feb 06 2001, Jeff V. Merkey wrote:
> > Adaptec drivers had an oops.  Also, AIC7XXX also had some oops with it.
> 
> Do you still have this oops?
> 

I can recreate.  Will work on it tommorrow.  SCI testing today.

Jeff

> -- 
> Jens Axboe
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
