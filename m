Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316235AbSHOA5x>; Wed, 14 Aug 2002 20:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316258AbSHOA5x>; Wed, 14 Aug 2002 20:57:53 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:41722 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316235AbSHOA5w>; Wed, 14 Aug 2002 20:57:52 -0400
Subject: Re: RedHat 7.3 kernel fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matt Simonsen <matt_lists@careercast.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1029371653.26279.39.camel@mattswork>
References: <1029371653.26279.39.camel@mattswork>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 15 Aug 2002 02:00:01 +0100
Message-Id: <1029373201.28236.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-15 at 01:34, Matt Simonsen wrote:
> I did not install 2.4.18-4 which mentions the SMP kernel panic
> explicitly - should I have installed this before the -5 kernel? From the
> errata it seems the -4 is superseded by -5 implying I didn't need it.

Correct

> Also, should I be using the drivers on Compaq's site? My previous setup

Shouldnt need to for standard PC hardware

> At this point the machine known good hardware, although I moved some RAM
> into it along with the OS move and I'm just not sure where to go. It's

So you moved some RAM and it started crashing randomly. Does it pass
memtest 86 (3.0 or higher for ECC RAM)

Alan

