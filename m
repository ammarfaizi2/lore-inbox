Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272317AbRHXURw>; Fri, 24 Aug 2001 16:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272315AbRHXURl>; Fri, 24 Aug 2001 16:17:41 -0400
Received: from willow.seitz.com ([207.106.55.140]:60944 "EHLO willow.seitz.com")
	by vger.kernel.org with ESMTP id <S272318AbRHXURb>;
	Fri, 24 Aug 2001 16:17:31 -0400
From: Ross Vandegrift <ross@willow.seitz.com>
Date: Fri, 24 Aug 2001 16:17:47 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4 broken on 486SX
Message-ID: <20010824161747.A10618@willow.seitz.com>
In-Reply-To: <20010824154233.A10048@willow.seitz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010824154233.A10048@willow.seitz.com>; from ross@willow.seitz.com on Fri, Aug 24, 2001 at 03:42:33PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ack, that was a horrific problem report.  Here are a few relevant data points I left out:

Kernels have always been compiled only with 386 optimizations.
	(tried 486 a few times, no difference)
Always built including soft float support (not that it matters so early)
Always built with gcc 2.95.2
Same kernel binaries work perfectly on a number of other boxen:
	A 386DX, a number of Pentium 100's, another 486SX, and a K6-2


Ross Vandegrift
ross@willow.seitz.com
