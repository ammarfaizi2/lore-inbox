Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284297AbRLMQTk>; Thu, 13 Dec 2001 11:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284330AbRLMQTa>; Thu, 13 Dec 2001 11:19:30 -0500
Received: from mail.vzavenue.net ([66.171.36.252]:54614 "EHLO
	mail.vzavenue.net") by vger.kernel.org with ESMTP
	id <S284297AbRLMQTR>; Thu, 13 Dec 2001 11:19:17 -0500
Date: Thu, 13 Dec 2001 22:16:56 +0000
From: Richard Todd <richardt@vzavenue.net>
To: David Lang <david.lang@digitalinsight.com>
Cc: "Eric S. Raymond" <esr@thyrsus.com>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 1.9.8
Message-ID: <20011213221656.A1667@localhost.localdomain>
In-Reply-To: <20011213040637.A9104@thyrsus.com> <Pine.LNX.4.40.0112130130120.7706-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.40.0112130130120.7706-100000@dlang.diginsite.com>; from david.lang@digitalinsight.com on Thu, Dec 13, 2001 at 01:30:53AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2001 at 01:30:53AM -0800, David Lang wrote:
> does this problem (and fix) also apply to the adventure mode (just
> checking to see how unified the output section really is :-)

Yes. 

I've tried it and it made the outputs the same for me..  

Note that it wasn't as simple as a different output from the 
*configs.  Only after three consecutive runs of oldconfig 
(starting from nothing) did my config.out stabilize before.

As was noted, the only 'problem' was that it was hard to be warm and
fuzzy about the outputs producing the same kernel in the end.  

Richard
