Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285449AbRLGLEW>; Fri, 7 Dec 2001 06:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285451AbRLGLEN>; Fri, 7 Dec 2001 06:04:13 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:44548 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S285449AbRLGLDz>; Fri, 7 Dec 2001 06:03:55 -0500
Date: Fri, 7 Dec 2001 11:01:58 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Keith Owens <kaos@ocs.com.au>
Cc: Tom Rini <trini@kernel.crashing.org>, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [kbuild-devel] (no subject)
Message-ID: <20011207110158.B1500@flint.arm.linux.org.uk>
In-Reply-To: <20011207043059.GI30935@cpe-24-221-152-185.az.sprintbbd.net> <24800.1007699773@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <24800.1007699773@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Fri, Dec 07, 2001 at 03:36:13PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2001 at 03:36:13PM +1100, Keith Owens wrote:
> We will not get all architectures converted in 48 hours or even 72.
> kbuild 2.5 has been available for months and only i386, ia64, sparc32
> (I did all those) and sparc64 (Ben Collins) have been converted.  Alpha
> is in progress.  Unconverted architectures stay on 2.5.2-pre1 until
> they do the conversion, but there is no need to hold up everybody else.

It's a shame that you were too busy to discuss the bugs I found in
kbuild 2.5 6 months ago when I tried it on ARM, despite me following
it up since.

My sympathies are with Tom here, and I think there should be longer than
24 hours for this.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

