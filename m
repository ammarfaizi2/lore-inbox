Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135618AbRD1Txb>; Sat, 28 Apr 2001 15:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135619AbRD1TxV>; Sat, 28 Apr 2001 15:53:21 -0400
Received: from p3EE3C9BA.dip.t-dialin.net ([62.227.201.186]:15621 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S135618AbRD1TxR>; Sat, 28 Apr 2001 15:53:17 -0400
Date: Sat, 28 Apr 2001 21:53:13 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4-pre7 build failure w/ IP NAT and ipchains
Message-ID: <20010428215313.A15429@emma1.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0104272012410.1256-100000@vaio> <15081.58646.799622.9357@pizda.ninka.net> <15081.63650.574602.341411@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15081.63650.574602.341411@pizda.ninka.net>; from davem@redhat.com on Fri, Apr 27, 2001 at 15:54:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Apr 2001, David S. Miller wrote:

> Kai, can you try this patch out?  I think it does the right
> thing.  What I'm mostly interested in is if your ipchains
> setup works for the resulting kernel, I've already checked
> that it links properly. :-)

I'm not Kai, but I also reported similar problems, and tried your patch,
and I can confirm it working.
