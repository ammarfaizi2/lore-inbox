Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314499AbSDXAeX>; Tue, 23 Apr 2002 20:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314500AbSDXAdW>; Tue, 23 Apr 2002 20:33:22 -0400
Received: from holomorphy.com ([66.224.33.161]:30132 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S314498AbSDXAdU>;
	Tue, 23 Apr 2002 20:33:20 -0400
Date: Tue, 23 Apr 2002 17:32:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dieter N?tzel <Dieter.Nuetzel@hamburg.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4: Any plans for new bootmem and waitq patches?
Message-ID: <20020424003222.GK21206@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200204240013.53960.Dieter.Nuetzel@hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2002 at 12:13:53AM +0200, Dieter N?tzel wrote:
> Hello,
> I did some tests with bootmem-2.4.17-pre6 and waitq-2.4.17-mainline-1 (don't 
> know who wrote it in the first place) on top of 2.4.17-preX with good 
> results.
> Are there any plans to get this into 2.4 mainline?
> Thanks,
> 	Dieter
> BTW waitq-2.4.17-mainline-1 do not apply to latest kernel versions.

Well, I wrote both.

The bootmem patch's benefits are not very visible (if at all) for
machines other than simulators and some unusual large systems. I
am not pressing for its inclusion in mainline for the basic reason
that what it addresses does not affect the systems I'm using anymore,
if only because the systems changed. =)

The waitqueue patch has been integrated into both mainline 2.4 and 2.5.

Cheers,
Bill
