Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275973AbRJYSvj>; Thu, 25 Oct 2001 14:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275990AbRJYSv3>; Thu, 25 Oct 2001 14:51:29 -0400
Received: from marine.sonic.net ([208.201.224.37]:7282 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S275983AbRJYSvV>;
	Thu, 25 Oct 2001 14:51:21 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Thu, 25 Oct 2001 11:51:53 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: modprobe problem with block-major-11
Message-ID: <20011025115153.A4138@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27036.1004015036@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2001 at 11:03:56PM +1000, Keith Owens wrote:
> Workaround: Replace 
>   pre-install foo modprobe bar
> with
>   before foo bar

Actually, below foo bar, but that worked great.

I will ask the authors of CD-Writing-HOWTO to update their docs.

Thanks,
mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
