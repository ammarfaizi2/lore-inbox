Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283653AbRLCXq0>; Mon, 3 Dec 2001 18:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282984AbRLCXof>; Mon, 3 Dec 2001 18:44:35 -0500
Received: from FSG1.nws.noaa.gov ([140.90.20.103]:20656 "EHLO
	fsg1.nws.noaa.gov") by vger.kernel.org with ESMTP
	id <S284937AbRLCSjy>; Mon, 3 Dec 2001 13:39:54 -0500
Date: Mon, 3 Dec 2001 13:39:53 -0500 (EST)
From: Brian McEntire <brianm@fsg1.nws.noaa.gov>
To: Ingo Molnar <mingo@redhat.com>
cc: <linux-kernel@vger.kernel.org>, <systems@clifford.nws.noaa.gov>
Subject: Re: PROBLEM: system hangs on dual 1GHz PIII system with 2.4.13-ac8
In-Reply-To: <Pine.LNX.4.33.0112031332490.28071-100000@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.33.0112031336100.25875-100000@fsg1.nws.noaa.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll gladly try it, I prefer running stock Redhat released kernels anyway, 
but last time I checked, only 2.4.9-13 was out and it didn't fix the crash 
problem. So I went with the latest stable -ac kernel.

I can't boot kernels except for -ac patched kernels (because I have ext3 
file systems that I converted during the 7.1 -> 7.2 upgrade.)

Where can I get the 2.4.17-2 kernel or RPM?

Thanks!
  Brian

On Mon, 3 Dec 2001, Ingo Molnar wrote:

> 
> i'd strongly suggest for you to try something like 2.4.17-2, does it lock
> up as well?
> 
> 	Ingo
> 

