Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276643AbRJKSPL>; Thu, 11 Oct 2001 14:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276650AbRJKSPC>; Thu, 11 Oct 2001 14:15:02 -0400
Received: from dfw-smtpout4.email.verio.net ([129.250.36.44]:6546 "EHLO
	dfw-smtpout4.email.verio.net") by vger.kernel.org with ESMTP
	id <S276643AbRJKSOo>; Thu, 11 Oct 2001 14:14:44 -0400
Message-ID: <3BC5E0BB.C12861A2@bigfoot.com>
Date: Thu, 11 Oct 2001 11:11:07 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20p10i i686)
X-Accept-Language: en
MIME-Version: 1.0
To: jkp@riker.nailed.org
CC: linux-kernel@vger.kernel.org
Subject: Re: Which kernel (Linus or ac)?
In-Reply-To: <XFMail.20011011094548.jkp@riker.nailed.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jkp@riker.nailed.org wrote:
> 
> I'm presently running 2.4.8 on a machine. The VM on this is not terribly
> good (swaps a lot with seemlingly plenty of physical memory).
> I'm considering going to an -ac kernel, but I need recent iptables. Is the
> iptables code up to date in -ac?
> Also, which -ac do people recommend? I've beent trying to follow lkm, but
> I'm somewhat confused at this point.
> 
> The box:
> 
> P200MMX 64MB
> 
> It's used as a firewall and a ssh login/through server for external connections.

Any reason not to stick with 2.2.20preX?  Especially where stability is
important.

rgds,
tim.
--
