Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263872AbTDHCME (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 22:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263876AbTDHCME (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 22:12:04 -0400
Received: from almesberger.net ([63.105.73.239]:22791 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S263872AbTDHCMD (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 22:12:03 -0400
Date: Mon, 7 Apr 2003 23:23:02 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Andi Kleen <ak@suse.de>
Cc: Robert Williamson <robbiew@us.ibm.com>, linux-kernel@vger.kernel.org,
       aniruddha.marathe@wipro.com, ltp-list@lists.sourceforge.net
Subject: Re: Same syscall is defined to different numbers on 3 different archs(was Re: Makefile  issue)
Message-ID: <20030407232302.D19288@almesberger.net>
References: <OF51DE965A.FDCB6DBE-ON85256D01.005201B1-86256D01.005610CF@pok.ibm.com.suse.lists.linux.kernel> <p73vfxqxpz4.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73vfxqxpz4.fsf@oldwotan.suse.de>; from ak@suse.de on Mon, Apr 07, 2003 at 05:54:39PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> #include </path/to/kernel/source/include/asm-<arch>/unistd.h>
> (you need the version in the kernel source because many glibc packagers
> in their infinite wisdom use an old outdated copy of asm/ usually from
> the last stable kernel only) 

Do we need a /proc/syscalls ? :-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
