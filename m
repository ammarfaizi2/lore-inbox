Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265381AbSJXK30>; Thu, 24 Oct 2002 06:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265382AbSJXK3Z>; Thu, 24 Oct 2002 06:29:25 -0400
Received: from rth.ninka.net ([216.101.162.244]:10397 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S265381AbSJXK3Y>;
	Thu, 24 Oct 2002 06:29:24 -0400
Subject: Re: sendfile64() anyone? (was [RESEND] tuning linux for high
	network performance?)
From: "David S. Miller" <davem@rth.ninka.net>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: bert hubert <ahu@ds9a.nl>, netdev@oss.sgi.com,
       Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200210241230.46848.roy@karlsbakk.net>
References: <200210231218.18733.roy@karlsbakk.net>
	<200210231542.48673.roy@karlsbakk.net>
	<1035432669.9628.1.camel@rth.ninka.net> 
	<200210241230.46848.roy@karlsbakk.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 24 Oct 2002 03:47:43 -0700
Message-Id: <1035456463.10555.7.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-24 at 03:30, Roy Sigurd Karlsbakk wrote:
> Are there any plans of implementing sendfile64() or sendfile() support for 
> -D_FILE_OFFSET_BITS=64?

This is old hat, and appears in every current vendor kernel I am
aware of and is in 2.5.x as well.

