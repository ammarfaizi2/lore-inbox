Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275012AbRJNJwD>; Sun, 14 Oct 2001 05:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275042AbRJNJvx>; Sun, 14 Oct 2001 05:51:53 -0400
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:56584 "HELO
	ns.higherplane.net") by vger.kernel.org with SMTP
	id <S275012AbRJNJvp>; Sun, 14 Oct 2001 05:51:45 -0400
Date: Sun, 14 Oct 2001 19:51:55 +1000
From: john slee <indigoid@higherplane.net>
To: Paul Gortmaker <p_gortmaker@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Making diff(1) of linux kernels faster
Message-ID: <20011014195154.A5511@higherplane.net>
In-Reply-To: <3BC953B5.18870B14@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BC953B5.18870B14@yahoo.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2001 at 04:58:29AM -0400, Paul Gortmaker wrote:
> So, with the cold cache, my patch cut the time by a factor of 5(!!)
> and the amount of audible death growls from the disk is also reduced.  
> In the warm case, you pay a slight penalty since the simple hack
> doesn't try to keep the file data around while priming the cache.

excellent.  how does it go on other kernels?  (solaris? irix? win32?)

j.

-- 
R N G G   "Well, there it goes again... And we just sit 
 I G G G   here without opposable thumbs." -- gary larson
