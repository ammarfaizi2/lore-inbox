Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282215AbRKWULV>; Fri, 23 Nov 2001 15:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282219AbRKWULL>; Fri, 23 Nov 2001 15:11:11 -0500
Received: from willow.seitz.com ([207.106.55.140]:7943 "EHLO willow.seitz.com")
	by vger.kernel.org with ESMTP id <S282215AbRKWUK4>;
	Fri, 23 Nov 2001 15:10:56 -0500
From: Ross Vandegrift <ross@willow.seitz.com>
Date: Fri, 23 Nov 2001 15:10:53 -0500
To: rpjday <rpjday@mindspring.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: is 2.4.15 really available at www.kernel.org?
Message-ID: <20011123151053.B13009@willow.seitz.com>
In-Reply-To: <7xpu69sttm.fsf@colargol.tihlde.org> <Pine.LNX.4.33.0111230523340.8063-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0111230523340.8063-100000@localhost.localdomain>; from rpjday@mindspring.com on Fri, Nov 23, 2001 at 05:27:08AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> then i'm just plain baffled.  using mozilla, i've tried downloading both 
> 2.4.15 and 2.5.0, from the main www.kernel.org page, and from the kernel
> subpage.  in *every* case, the download window starts off fine with
> "0K of 28716K", so it knows the right size at the beginning.

Turn your MTU down to 1490, maybe smaller.  There is a broken TCP/IP stack 
or switch between you and kernel.org.

Ross Vandegrift
ross@willow.seitz.com
