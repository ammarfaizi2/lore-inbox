Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269334AbRHQBFT>; Thu, 16 Aug 2001 21:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269350AbRHQBFJ>; Thu, 16 Aug 2001 21:05:09 -0400
Received: from odyssey.netrox.net ([204.253.4.3]:38069 "EHLO t-rex.netrox.net")
	by vger.kernel.org with ESMTP id <S269334AbRHQBFF>;
	Thu, 16 Aug 2001 21:05:05 -0400
Subject: Re: /dev/random in 2.4.6
From: Robert Love <rml@tech9.net>
To: Robert Love <rml@tech9.net>
Cc: Andreas Dilger <adilger@turbolabs.com>, Steve Hill <steve@navaho.co.uk>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <998009344.664.72.camel@phantasy>
In-Reply-To: <200108151713.f7FHDg0n013420@webber.adilger.int>
	<Pine.LNX.4.21.0108160934340.2107-100000@sorbus.navaho> 
	<20010816131112.V31114@turbolinux.com>  <998009344.664.72.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 16 Aug 2001 21:05:04 -0400
Message-Id: <998010345.664.76.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Aug 2001 20:49:01 -0400, Robert Love wrote:
> I put together a patch that addresses this, it allows the user to
> configure whether or not network devices contribute to the entropy pool.
> more information can be found

i guess i should mention where:

see the thread "[PATCH] Optionally let Net Devices feed Entropy" or
http://tech9.net/rml/linux

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

