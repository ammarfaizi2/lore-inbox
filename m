Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271174AbRHOM2y>; Wed, 15 Aug 2001 08:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271167AbRHOM2p>; Wed, 15 Aug 2001 08:28:45 -0400
Received: from wb2-a.mail.utexas.edu ([128.83.126.136]:2576 "HELO
	mail.utexas.edu") by vger.kernel.org with SMTP id <S271174AbRHOM2g>;
	Wed, 15 Aug 2001 08:28:36 -0400
Message-ID: <3B7A6B01.72FBD2F8@mail.utexas.edu>
Date: Wed, 15 Aug 2001 07:28:49 -0500
From: "Bobby D. Bryant" <bdbryant@mail.utexas.edu>
Organization: (I do not speak for) The University of Texas at Austin (nor they for 
 me).
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.5-22smp i686)
X-Accept-Language: en,fr,de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Via chipset
In-Reply-To: <E15WzAC-00034X-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> We know it happens on some boards that apparently cant keep up. We dont know
> why, there is no time estimate for a cure. That unfortunately is about it

FWIW (qualitative data point), my EPoX system with the VIA chipset seems to run a
few *hours* without an oops when I boot a PIII kernel and run it with X, but a few
*days* on the same kernel when I don't start X.

Sometimes it barfs early even without X, but there seems to be a significant
difference in the expected uptime between using X and not using X.

Bobby Bryant
Austin, Texas


