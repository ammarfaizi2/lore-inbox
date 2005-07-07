Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVGGIR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVGGIR2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 04:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVGGIR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 04:17:27 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:22693 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S261241AbVGGIRZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 04:17:25 -0400
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: 7eggert@gmx.de
Subject: Re: OOPS: frequent crashes with bttv in 2.6.X series (inc. 2.6.12)
Date: Thu, 7 Jul 2005 10:17:22 +0200
User-Agent: KMail/1.8.1
Cc: Jeremy Laine <jeremy.laine@polytechnique.org>,
       linux-kernel@vger.kernel.org
References: <4njei-1Ps-21@gated-at.bofh.it> <E1DqJ1b-0001Li-0t@be1.7eggert.dyndns.org>
In-Reply-To: <E1DqJ1b-0001Li-0t@be1.7eggert.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507071017.22697.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've seen similar hehaviour (machine halts) with a BT848 on a VT82C686
> board while displaying the picture on a radeon card under X.org 6.8.1.

I have the same problem with a Bt878 on a VT82C686 board with a Radeon 7500
card.  The problem predates X.org.

> Heavy HDD IO almost certainly caused soon death (recognizable by heavy
> picture distortion), while an idle system lasted one evening. It did not
> happen with kernel 2.4 and a NVidia card on XF86.

I get hard hangs.

> Now I've upgraded to X.org 6.8.2 and done a first stress-test (copying
> large files from network to local HDD), and I still can post.

Thanks for the hint - I will try updating X.org too.

All the best,

Duncan.
