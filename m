Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261764AbTCYJAp>; Tue, 25 Mar 2003 04:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261765AbTCYJAp>; Tue, 25 Mar 2003 04:00:45 -0500
Received: from tapu.f00f.org ([202.49.232.129]:58541 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S261764AbTCYJAo>;
	Tue, 25 Mar 2003 04:00:44 -0500
Date: Tue, 25 Mar 2003 01:11:53 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: PATCH: newer boards put other hw at rtc + 0x08
Message-ID: <20030325091153.GA32193@f00f.org>
References: <200303211924.h2LJObKX025741@hraefn.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303211924.h2LJObKX025741@hraefn.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 07:24:37PM +0000, Alan Cox wrote:

> -#define RTC_IO_EXTENT 0x10 /* Only really two ports, but... */
> +#define RTC_IO_EXTENT 0x8

If the comment was/is correct then was not 0x2?


  --cw
