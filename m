Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277703AbRJ1FRZ>; Sun, 28 Oct 2001 01:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277717AbRJ1FRP>; Sun, 28 Oct 2001 01:17:15 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:42235
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S277703AbRJ1FRD>; Sun, 28 Oct 2001 01:17:03 -0400
Date: Sat, 27 Oct 2001 22:17:33 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Samium Gromoff <_deepfire@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Nice stats gathering idea
Message-ID: <20011027221733.B20280@mikef-linux.matchmail.com>
Mail-Followup-To: Samium Gromoff <_deepfire@mail.ru>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200110272235.f9RMZv920026@vegae.deep.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200110272235.f9RMZv920026@vegae.deep.net>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2001 at 02:35:57AM +0400, Samium Gromoff wrote:
> 	Hello folks, gotta an idea, well discovery:
>  do vmstat 1; then strike scroll lock
>  wait for the delay you want to measure the overall, and release the scrolling
>  *bah* - you have the overall stats for the VM usage for a given period
> 

Or even better, use vmstat 15 or 30 or etc...  That way you know what the
time period should be...
