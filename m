Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316578AbSHHHwV>; Thu, 8 Aug 2002 03:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316757AbSHHHwV>; Thu, 8 Aug 2002 03:52:21 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:5638 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id <S316578AbSHHHwU>;
	Thu, 8 Aug 2002 03:52:20 -0400
Date: Thu, 8 Aug 2002 09:55:36 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "Anthony Russo., a.k.a. Stupendous Man" <anthony.russo@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 BUG in page_alloc.c:91
Message-ID: <20020808075536.GB943@alpha.home.local>
References: <Pine.LNX.4.44L.0208072350060.23404-100000@imladris.surriel.com> <3D51DD80.6070501@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D51DD80.6070501@verizon.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2002 at 10:54:56PM -0400, Anthony Russo., a.k.a. Stupendous Man wrote:
>  I don't believe I have any "proprietary" modules loaded, but
> here is the output of lsmod:

but a proprietary module *has* been loaded and then removed before your
lsmod, right ? wouldn't it be nvidia's ? the oops ressembles the one many
nvidia users experiment. 

Regards,
Willy
 
