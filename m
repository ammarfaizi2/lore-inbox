Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262792AbSIPTbB>; Mon, 16 Sep 2002 15:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262794AbSIPTbB>; Mon, 16 Sep 2002 15:31:01 -0400
Received: from p50887801.dip.t-dialin.net ([80.136.120.1]:15257 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S262792AbSIPTbA>; Mon, 16 Sep 2002 15:31:00 -0400
Date: Mon, 16 Sep 2002 13:36:23 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Daniel Phillips <phillips@arcor.de>
cc: Thunder from the hill <thunder@lightweight.ods.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
In-Reply-To: <E17r0s7-0000KS-00@starship>
Message-ID: <Pine.LNX.4.44.0209161335480.342-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 16 Sep 2002, Daniel Phillips wrote:
> On Monday 16 September 2002 20:35, Thunder from the hill wrote:
> > !assert(typeof((fool)->next) == typeof(fool));
> 
> You meant:
> 
> 	assert(typeof((fool)->next) != typeof(fool));

No, I mean "Never assert that the one next to a fool must be a fool, 
either. You might be wrong."

			Thunder
-- 
!assert(typeof((fool)->next) == typeof(fool));

