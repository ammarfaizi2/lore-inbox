Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262768AbSI1JoD>; Sat, 28 Sep 2002 05:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262778AbSI1JoD>; Sat, 28 Sep 2002 05:44:03 -0400
Received: from pD9E23260.dip.t-dialin.net ([217.226.50.96]:2439 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S262768AbSI1JoC>; Sat, 28 Sep 2002 05:44:02 -0400
Date: Sat, 28 Sep 2002 03:50:06 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Felix Seeger <felix.seeger@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: System very unstable
In-Reply-To: <200209281134.27362.felix.seeger@gmx.de>
Message-ID: <Pine.LNX.4.44.0209280348150.7827-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 28 Sep 2002, Felix Seeger wrote:
> Yes I am using the nvidia module. But I don't think that is the problem,
> because I never had such problems with it.
> The only thing I can imagine is that:
> I installed the new module and I looked very unstable. So I installed the old
> one again.

You got that wrong. It's not meant to be a torture on the user, but it's 
rather that NVdriver only works on kernels it was explicitly written for. 
Otherwise most things just won't match. That's where NVdriver uses to hit.

Please check again without ever loading the NVdriver. (i.e. from a clean 
reboot.)

			Thunder
-- 
assert(typeof((fool)->next) == typeof(fool));	/* wrong */

