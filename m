Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316825AbSFZUsf>; Wed, 26 Jun 2002 16:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316827AbSFZUse>; Wed, 26 Jun 2002 16:48:34 -0400
Received: from holomorphy.com ([66.224.33.161]:56531 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316825AbSFZUsd>;
	Wed, 26 Jun 2002 16:48:33 -0400
Date: Wed, 26 Jun 2002 13:47:21 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Alexandre Pereira Nunes <alex@PolesApart.dhs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.19-pre10-ac2 bug in page_alloc.c:131
Message-ID: <20020626204721.GK22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alexandre Pereira Nunes <alex@PolesApart.dhs.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0206222202400.7601-100000@PolesApart.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0206222202400.7601-100000@PolesApart.dhs.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 22, 2002 at 10:13:52PM -0300, Alexandre Pereira Nunes wrote:
> Hi, I'm using kernel 2.4.19-pre10-ac2 and it just printed the pretty
> message below. Other pertinent information follows.
> CC: if needed, because I'm not in the list.
> Cheers,
> Alexandre
>  <3>X[3924] exited with preempt_count 1

Would you mind showing us the patch you used to merge preempt into -ac?


Thanks,
Bill
