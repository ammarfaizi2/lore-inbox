Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271758AbRHRBTi>; Fri, 17 Aug 2001 21:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271759AbRHRBT2>; Fri, 17 Aug 2001 21:19:28 -0400
Received: from [209.202.108.240] ([209.202.108.240]:50703 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S271758AbRHRBTO>; Fri, 17 Aug 2001 21:19:14 -0400
Date: Fri, 17 Aug 2001 21:19:15 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: is there a way to let kernel to skip one region of physical
 memory?
In-Reply-To: <Pine.LNX.4.33.0108172058160.5581-100000@tiger>
Message-ID: <Pine.LNX.4.33.0108172118370.4479-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2001, Feng Xian wrote:

> Hi, all,
>
> I have a question. say I have 128M physical memory, but for some reason, I
> don't want the kernel to use a little part of that memory, e.g. physical
> address from 4M to 5M. is there a way to let the kernel to do something
> like this? thanks in advance.
>
> Alex

Look in the archives for a thread entitled 'broken memory chip -> software
fix?' that you JUST missed.

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

