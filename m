Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263254AbREWUr3>; Wed, 23 May 2001 16:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263253AbREWUrU>; Wed, 23 May 2001 16:47:20 -0400
Received: from draco.macsch.com ([192.73.8.1]:19951 "EHLO draco.macsch.com")
	by vger.kernel.org with ESMTP id <S263252AbREWUrF>;
	Wed, 23 May 2001 16:47:05 -0400
Message-ID: <3B0C21C6.A78FEDB6@mscsoftware.com>
Date: Wed, 23 May 2001 13:47:02 -0700
From: "David N. Lombard" <david.lombard@mscsoftware.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-8.msc-up i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Patric Mrawek <mrawek@punkt.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Boot Problem
In-Reply-To: <20010523140356.A38056@punkt.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patric Mrawek wrote:
> 
> Hi,
> 
> sometimes one of my servers doesn't boot correctly. Lilo reads the
> kernel-image, but doesn't decompress it. So the system won't
> continue booting.
> 
> Looks like:
> Loading linux...................
> (at this point the machine freezes)

Our experience of this has been with suspect hardware.  It was our first
(pre-release) P4 system, so we puzzled over it for a short while; later
testing on other P4 systems showed no such problem.

-- 
David N. Lombard
