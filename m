Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbUJYQAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbUJYQAN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 12:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbUJYP7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:59:51 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:47626 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S262001AbUJYPka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:40:30 -0400
Message-ID: <417D216D.1060206@techsource.com>
Date: Mon, 25 Oct 2004 11:53:17 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Tonnerre <tonnerre@thundrix.ch>
CC: Helge Hafting <helgehaf@aitel.hist.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
References: <4176E08B.2050706@techsource.com> <1098442636l.17554l.0l@hh> <20041025152921.GA25154@thundrix.ch>
In-Reply-To: <20041025152921.GA25154@thundrix.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Tonnerre wrote:
> Salut,
> 
> On Fri, Oct 22, 2004 at 10:57:16AM +0000, Helge Hafting wrote:
> 
>>24-bit color
>>------------
> 
> 
> Why don't you use 32-bit colors?  24-bit packed pixels are a pita, and
> a lot of OpenGL hardware doesn't support 24bpp. You might atcually get
> better graphics/performance/etc. if you  stick to 32bpp. Only that the
> framebuffer size increases by 1/3rd.

It's been ages since I've encountered a GPU which could do packed 24.  I 
think when people talk about "24 bit color", they're also thinking "32 
bits per pixel".  Besides, there's the alpha channel.

