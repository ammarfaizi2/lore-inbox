Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263349AbTC0RgL>; Thu, 27 Mar 2003 12:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263354AbTC0RgL>; Thu, 27 Mar 2003 12:36:11 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:30728 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263349AbTC0RgK>;
	Thu, 27 Mar 2003 12:36:10 -0500
Date: Thu, 27 Mar 2003 09:46:22 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at sched.c:564! (2.4.20, 2.4.21-pre5-ac3)
Message-ID: <20030327174622.GC32667@kroah.com>
References: <20030326162538.GG2695@spackhandychoptubes.co.uk> <20030326185236.GE24689@kroah.com> <20030326192520.GH2695@spackhandychoptubes.co.uk> <20030326193437.GI24689@kroah.com> <20030327111600.GI2695@spackhandychoptubes.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030327111600.GI2695@spackhandychoptubes.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 11:16:00AM +0000, Chris Sykes wrote:
> 
> No Oopsen or errors in dmesg as yet. (Before I was getting many errors
> about 0 size writes).

Great, thanks for testing.

> I can keep working under 2.5.66 for now to see if I experience any
> problems, but it would appear that the race is gone in 2.5.66
> (CONFIG_PREEMPT=y)
> 
> If you'd like me to try any patches against 2.4 just let me know.

Will do, if I get the chance to make any up :)

thanks again,

greg k-h
