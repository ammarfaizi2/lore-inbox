Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267189AbTBPP4B>; Sun, 16 Feb 2003 10:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267190AbTBPP4A>; Sun, 16 Feb 2003 10:56:00 -0500
Received: from [24.206.178.254] ([24.206.178.254]:18307 "EHLO
	mail.brianandsara.net") by vger.kernel.org with ESMTP
	id <S267189AbTBPPz5>; Sun, 16 Feb 2003 10:55:57 -0500
From: Brian Jackson <brian@mdrx.com>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: 2.5 AGP for 2.4.21-pre4
Date: Sun, 16 Feb 2003 10:04:53 -0600
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200302152135.22425.brian@mdrx.com> <20030216143005.GA481@codemonkey.org.uk>
In-Reply-To: <20030216143005.GA481@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302161004.53012.brian@mdrx.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 February 2003 08:30 am, Dave Jones wrote:
> On Sat, Feb 15, 2003 at 09:35:22PM -0600, Brian Jackson wrote:
>  > P.S.S. To Dave Jones -- I thought 2.5 had support for VIA chipsets &
>  > AGP3, but I only saw config options for the 7205/7505
>
> If CONFIG_AGP3 is set, then the agp3 routines in via-agp.c also get
> built, so you get KT400 support.
>
> 		Dave

That is what it looked like as I started looking through some of the code, I 
just wasn't sure. Thanks for the answer.

--Brian Jackson
