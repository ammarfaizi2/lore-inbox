Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318302AbSHKOZz>; Sun, 11 Aug 2002 10:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318304AbSHKOZz>; Sun, 11 Aug 2002 10:25:55 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:52733 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S318302AbSHKOZz>;
	Sun, 11 Aug 2002 10:25:55 -0400
Date: Sun, 11 Aug 2002 10:29:38 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/21] random fixes
Message-ID: <20020811142938.GA681@www.kroptech.com>
References: <3D56146B.C3CAB5E1@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D56146B.C3CAB5E1@zip.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2002 at 12:38:19AM -0700, Andrew Morton wrote:
> Sorry, but there's a ton of stuff here.  It ends up as a 4600 line
> diff.  Some code dating back to 2.5.24.  It's almost all performance

Andrew,

Nearly all the patches against mm/vmscan.c are failing when applied
to the 2.5.31 Linus just released. Are these patches against a
slightly older BK rev?

--Adam

