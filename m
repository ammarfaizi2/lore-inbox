Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290941AbSASLlA>; Sat, 19 Jan 2002 06:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290942AbSASLkt>; Sat, 19 Jan 2002 06:40:49 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:48395 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S290941AbSASLkk>;
	Sat, 19 Jan 2002 06:40:40 -0500
Date: Sat, 19 Jan 2002 12:40:17 +0100
From: Jens Axboe <axboe@suse.de>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Andre Hedrick <andre@linuxdiskcert.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
Message-ID: <20020119124017.G27835@suse.de>
In-Reply-To: <Pine.LNX.4.10.10201181127270.4260-100000@master.linux-ide.org> <Pine.LNX.4.40.0201181146100.934-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0201181146100.934-100000@blue1.dev.mcafeelabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18 2002, Davide Libenzi wrote:
> Guys, instead of requiring an -m8 to every user that is observing this
> problem, isn't it better that you limit it inside the driver until things
> gets fixed ?

There is no -m8 limit, 2.5.3-pre1 + ata253p1-2 patch handles any set
multi mode value.

-- 
Jens Axboe

