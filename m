Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131334AbRBDBBn>; Sat, 3 Feb 2001 20:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131365AbRBDBBe>; Sat, 3 Feb 2001 20:01:34 -0500
Received: from www.inreko.ee ([195.222.18.2]:29136 "EHLO www.inreko.ee")
	by vger.kernel.org with ESMTP id <S131334AbRBDBBP>;
	Sat, 3 Feb 2001 20:01:15 -0500
Date: Sun, 4 Feb 2001 03:11:35 +0200
From: Marko Kreen <marko@l-t.ee>
To: Shawn Starr <Shawn.Starr@Home.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PS hanging in 2.4.1 - HAPPENING NOW!!!
Message-ID: <20010204031135.B23913@l-t.ee>
In-Reply-To: <3A7C8AC4.D3CAAF57@Home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A7C8AC4.D3CAAF57@Home.net>; from Shawn.Starr@Home.net on Sat, Feb 03, 2001 at 05:48:36PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 03, 2001 at 05:48:36PM -0500, Shawn Starr wrote:
> [root@coredump spstarr]# killall -9 gnomeicu
> 
> ... waiting...


Could you try it on 2.4.2ac2, I guess its this item:

o       Fix datagram hang on shutdown                   (Alexey
Kuznetsov)

-- 
marko

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
