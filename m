Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136215AbRBFBaM>; Mon, 5 Feb 2001 20:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136218AbRBFBaB>; Mon, 5 Feb 2001 20:30:01 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:36108 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S136215AbRBFB3s>;
	Mon, 5 Feb 2001 20:29:48 -0500
Date: Tue, 6 Feb 2001 02:29:38 +0100
From: Jens Axboe <axboe@suse.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: "Gregory T. Norris" <haphazard@socket.net>
Subject: Re: vmware 2.0.3, kernel 2.4.0 and a cdrom
Message-ID: <20010206022938.E9025@suse.de>
In-Reply-To: <20010205192235.A1567@glitch.snoozer.net> <20010206022722.D9025@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010206022722.D9025@suse.de>; from axboe@suse.de on Tue, Feb 06, 2001 at 02:27:22AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06 2001, Jens Axboe wrote:
> Interesting, does audio volume control work if you play an audio cd?

Nope it won't (just checked). I'll produce a patch for this
tomorrow, I know what's going on. Is this an old SCSI drive?

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
