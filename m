Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284973AbRLQCvw>; Sun, 16 Dec 2001 21:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284979AbRLQCvm>; Sun, 16 Dec 2001 21:51:42 -0500
Received: from ns.suse.de ([213.95.15.193]:21253 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284973AbRLQCvb>;
	Sun, 16 Dec 2001 21:51:31 -0500
Date: Mon, 17 Dec 2001 03:51:30 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: More fun with fsx.
In-Reply-To: <15389.19300.179304.433697@charged.uio.no>
Message-ID: <Pine.LNX.4.33.0112170350070.29678-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2001, Trond Myklebust wrote:

> No. I think I've got it. You are running NFSv2 (I assumed v3) and I'll
> bet that if you look in your syslog, you'll see the error message
> This is a bug that was fixed ages ago in the NFSv3 code. I've updated
> the 'fattr' patch yet again...

And it fixes the problem, good work!
But.. (Here comes the sting..)

The test progresses just a little further and hits another bug..
http://www.codemonkey.org.uk/cruft/nfs-fsx2.txt

want tcpdump again?

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

