Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312600AbSDEN3p>; Fri, 5 Apr 2002 08:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSDEN3f>; Fri, 5 Apr 2002 08:29:35 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:44301 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S312588AbSDEN33>; Fri, 5 Apr 2002 08:29:29 -0500
Date: Fri, 5 Apr 2002 14:29:23 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.0 is available
Message-ID: <20020405142923.B7061@flint.arm.linux.org.uk>
In-Reply-To: <p73k7rms6ba.fsf@oldwotan.suse.de> <7853.1018011163@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2002 at 10:52:43PM +1000, Keith Owens wrote:
> On a smaller config (full config takes too long when single threaded).
> 
> kbuild 2.4:
> 	make oldconfig dep bzImage modules	6:25
> 	make bzImage modules (no changes)	0:22
> 
> kbuild 2.5:
> 	make oldconfig installable		4:45
> 	make installable (no changes)		0:16

How does it compare in (ahem) 32-64MB machines?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

