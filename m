Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130224AbRBAJO2>; Thu, 1 Feb 2001 04:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130243AbRBAJOS>; Thu, 1 Feb 2001 04:14:18 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:32345 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S130224AbRBAJOG>; Thu, 1 Feb 2001 04:14:06 -0500
Date: Thu, 1 Feb 2001 10:13:46 +0100
From: Rainer Wiener <rainer@konqui.de>
To: LA Walsh <law@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: seti@home and es1371
Message-ID: <20010201101346.C4014@mulder.konqui.de>
In-Reply-To: <20010131171130.A1664@mulder.konqui.de> <3A786758.E607E63D@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A786758.E607E63D@sgi.com>; from law@sgi.com on Wed, Jan 31, 2001 at 11:28:24AM -0800
X-GPG-Fingerprint: 8F30 218F 1353 F984 1242  6FD3 3569 E885 C53E 61DA
X-Operating-System: Debian GNU/Linux Sid (Linux 2.4.1)
X-Homepage: http://www.konqui.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi LA!

On Wed, 31 Jan 2001, LA Walsh wrote:

> Try "freeamp".  It uses darn close to 0 CPU and may not be affected by setiathome.
> 2nd -- renice setiathome to '19' -- you only want it to use up 'background' cputime
> 	anyway

I also try freeamp with no success. Seti is also running with nice 19.

cu
Rainer
-- 
FORTUNE PROVIDES QUESTIONS FOR THE GREAT ANSWERS: #31
A:	Chicken Teriyaki.
Q:	What is the name of the world's oldest kamikaze pilot?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
