Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274596AbRITS1q>; Thu, 20 Sep 2001 14:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274598AbRITS1h>; Thu, 20 Sep 2001 14:27:37 -0400
Received: from [195.223.140.107] ([195.223.140.107]:10228 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274596AbRITS10>;
	Thu, 20 Sep 2001 14:27:26 -0400
Date: Thu, 20 Sep 2001 20:27:53 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Magnus Naeslund(f)" <mag@fbab.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10pre12aa1 pgbench
Message-ID: <20010920202753.O729@athlon.random>
In-Reply-To: <066a01c141c7$86c74c30$020a0a0a@totalmef>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <066a01c141c7$86c74c30$020a0a0a@totalmef>; from mag@fbab.net on Thu, Sep 20, 2001 at 01:29:35PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 01:29:35PM +0200, Magnus Naeslund(f) wrote:
> This is not any scientific super bench, but this is what matters for me :)
> 
> It's an Alpha UX-164 633mhz with 1.25GB memory.
> It's considerably slower than 2.4.5aa1, sorry to say.

I don't exclude it's a vm problem (and I know where to put the hands in
such case) but could you compare also with 2.4.10pre10 or anyways
something more recent than a 2.4.5 based kernel.  There are been changes
in the I/O subsystem as well meanwhile (ask Jens). I will also need to
check what pgbench is doing, where can I get it?

Andrea
