Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132127AbRCVSIR>; Thu, 22 Mar 2001 13:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132130AbRCVSH7>; Thu, 22 Mar 2001 13:07:59 -0500
Received: from raven.toyota.com ([63.87.74.200]:46351 "EHLO raven.toyota.com")
	by vger.kernel.org with ESMTP id <S132127AbRCVSHp>;
	Thu, 22 Mar 2001 13:07:45 -0500
Message-ID: <3ABA3F46.ECFF3569@toyota.com>
Date: Thu, 22 Mar 2001 10:07:02 -0800
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Brent D. Norris" <brent@biglinux.tccw.wku.edu>
CC: Kernel-mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Sound issues with m805lr motheboard
In-Reply-To: <Pine.LNX.4.30.0103220730450.4739-100000@biglinux.tccw.wku.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Brent D. Norris" wrote:

> > That seems strange. What is realserver failing with ?
>
> It isn't so much failing as it hangs.

It might be interesting to strace the realserver startup
both under 2.2 and 2.4 -

cu

Jup

