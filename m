Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281129AbRKLWrX>; Mon, 12 Nov 2001 17:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281158AbRKLWrO>; Mon, 12 Nov 2001 17:47:14 -0500
Received: from marine.sonic.net ([208.201.224.37]:37936 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S281129AbRKLWq7>;
	Mon, 12 Nov 2001 17:46:59 -0500
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Mon, 12 Nov 2001 14:46:52 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: File System Performance
Message-ID: <20011112144652.A6749@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3BF03402.87D44589@zip.com.au> <3BF03402.87D44589@zip.com.au> <1005600431.13303.10.camel@jen.americas.sgi.com> <3BF04289.8FC8B7B7@zip.com.au> <9spg3c$7bb$1@penguin.transmeta.com> <3BF04A37.29E19B1A@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BF04A37.29E19B1A@zip.com.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2001 at 02:16:23PM -0800, Andrew Morton wrote:
> One wonders why.

No, on doesn't:

>         Corrections to speed-up the sizeing pass in Amanda:

Granted, star's nullout option may have been smarter, and more in the realm
of ``least surprise,'' but one can understand why gtar does this.

Try tar cf /dev/zero instead.

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
