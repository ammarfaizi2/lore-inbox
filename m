Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267245AbTAGBgH>; Mon, 6 Jan 2003 20:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267255AbTAGBgH>; Mon, 6 Jan 2003 20:36:07 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:49158 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267245AbTAGBgG>;
	Mon, 6 Jan 2003 20:36:06 -0500
Date: Mon, 6 Jan 2003 17:44:41 -0800
From: Greg KH <greg@kroah.com>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: lvm-devel@sistina.com, linux-kernel@vger.kernel.org
Subject: Re: [lvm-devel] dm fs?
Message-ID: <20030107014441.GI23578@kroah.com>
References: <20030105213728.GA8239@gtf.org> <20030106094316.GC2543@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030106094316.GC2543@reti>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2003 at 09:43:17AM +0000, Joe Thornber wrote:
> 
> Both Andrew Morton and Greg KH expressed concerns with the way I've
> mapped the dm semantics onto the filesystem
> (http://marc.theaimsgroup.com/?l=linux-kernel&m=103975736919315&w=2).
> So Greg is currently trying to get a sysfs interface working.

Yes, and hopefully I'll have something that works later this week, after
I've dug out under this mount of email...

thanks,

gre k-h
