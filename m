Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131460AbRACWO2>; Wed, 3 Jan 2001 17:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131594AbRACWOS>; Wed, 3 Jan 2001 17:14:18 -0500
Received: from linuxcare.com.au ([203.29.91.49]:60431 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S131460AbRACWOH>; Wed, 3 Jan 2001 17:14:07 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Thu, 4 Jan 2001 09:12:19 +1100
To: James Moody <jemoody@scs.carleton.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sparc32: Error linking 2.4.0-prerelease
Message-ID: <20010104091219.B21322@linuxcare.com>
In-Reply-To: <20010101154648.A27569@sigma07.scs.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010101154648.A27569@sigma07.scs.carleton.ca>; from jemoody@scs.carleton.ca on Mon, Jan 01, 2001 at 03:46:48PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I get the following errors during the final linking of 2.4.0-prerelease
> on a Sparc IPX (sun4c). .config available upon request.

sun4c is badly broken at the moment for other reasons. However the problems
you are seeing should be fixed in cvs.

Anton
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
