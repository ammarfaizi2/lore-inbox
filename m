Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284972AbRLQB7B>; Sun, 16 Dec 2001 20:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284970AbRLQB6p>; Sun, 16 Dec 2001 20:58:45 -0500
Received: from ns.suse.de ([213.95.15.193]:61966 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284965AbRLQB6H>;
	Sun, 16 Dec 2001 20:58:07 -0500
Date: Mon, 17 Dec 2001 02:50:20 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: More fun with fsx.
In-Reply-To: <15389.20155.378980.692209@charged.uio.no>
Message-ID: <Pine.LNX.4.33.0112170249450.29678-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2001, Trond Myklebust wrote:

> Are the timestamps correct? If the server is replying with a 'garbage'
> message, then certainly that will result in an EIO. However I didn't
> see anything like that in your tcpdump, and the juxtaposed
> 'nfs_get_root' error rather points to that as being a mount error.

Timestamps match on client and server, and are the correct times.

regards,
Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

