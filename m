Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030352AbWEYTNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbWEYTNn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 15:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030354AbWEYTNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 15:13:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64957 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030352AbWEYTNm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 15:13:42 -0400
Date: Thu, 25 May 2006 12:13:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.17-rc5, patches patches
In-Reply-To: <Pine.LNX.4.61.0605251820080.6951@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64.0605251211250.5623@g5.osdl.org>
References: <Pine.LNX.4.64.0605241902520.5623@g5.osdl.org>
 <Pine.LNX.4.61.0605251820080.6951@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 25 May 2006, Jan Engelhardt wrote:
>
> On Fri, 12 May 2006 19:45:48 +0200 (MEST), Jan Engelhardt wrote:
> >http://lkml.org/lkml/2005/7/7/255
> 
> and
> http://lkml.org/lkml/2005/2/26/92
> 
> In 2.6.17-rc5, these two below have been merged, but the two above (which are
> way older) have not. What's up with that?

Were they pushed and cc'd to the maintainers? (And that partition dumper 
looks a bit like unnecessary bloat. If you don't know your partitions, I 
don't think just listing them is going to help much).

		Linus
