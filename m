Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130845AbRBGBJm>; Tue, 6 Feb 2001 20:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130826AbRBGBJc>; Tue, 6 Feb 2001 20:09:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:28435 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130909AbRBGBJT>;
	Tue, 6 Feb 2001 20:09:19 -0500
Date: Wed, 7 Feb 2001 02:08:53 +0100
From: Jens Axboe <axboe@suse.de>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        Ben LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010207020853.A14105@suse.de>
In-Reply-To: <20010207003629.M1167@redhat.com> <Pine.LNX.4.10.10102061642330.2045-100000@penguin.transmeta.com> <20010206185115.A23754@vger.timpanogas.org> <20010207020221.B13647@suse.de> <20010206190050.B23960@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010206190050.B23960@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Tue, Feb 06, 2001 at 07:00:50PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06 2001, Jeff V. Merkey wrote:
> Adaptec drivers had an oops.  Also, AIC7XXX also had some oops with it.

Do you still have this oops?

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
