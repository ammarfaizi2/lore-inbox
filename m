Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272717AbRI0MtY>; Thu, 27 Sep 2001 08:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272764AbRI0MtO>; Thu, 27 Sep 2001 08:49:14 -0400
Received: from curlew.cs.man.ac.uk ([130.88.13.7]:37382 "EHLO
	curlew.cs.man.ac.uk") by vger.kernel.org with ESMTP
	id <S272736AbRI0MtE>; Thu, 27 Sep 2001 08:49:04 -0400
Date: Thu, 27 Sep 2001 13:49:29 +0100
From: John Levon <moz@compsoc.man.ac.uk>
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: version.h
Message-ID: <20010927134929.D18860@compsoc.man.ac.uk>
In-Reply-To: <Pine.LNX.4.33.0109271032320.4588-100000@fargo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109271032320.4588-100000@fargo>
User-Agent: Mutt/1.3.19i
X-Url: http://www.movement.uklinux.net/
X-Record: Truant - Neither Work Nor Leisure
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2001 at 10:36:47AM +0200, David =?ISO-8859-1?Q?G=F3mez ?= wrote:

> It seems that in 2.4.10 include/linux/version.h has not updated the macro
> UTS_VERSION to the new kernel version. I found this error when trying to
> compile alsa-drivers and the configure script couldn't find the right
> modules directory.

that file is auto-generated. Read the kernel howto and make sure to go through
all the necessary build steps first.

regards
john

-- 
" It is quite humbling to realize that the storage occupied by the longest line
from a typical Usenet posting is sufficient to provide a state space so vast
that all the computation power in the world can not conquer it."
	- Dave Wallace
