Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265389AbSJXKxb>; Thu, 24 Oct 2002 06:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265390AbSJXKxb>; Thu, 24 Oct 2002 06:53:31 -0400
Received: from 213-187-164-2.dd.nextgentel.com ([213.187.164.2]:29848 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S265389AbSJXKxa> convert rfc822-to-8bit;
	Thu, 24 Oct 2002 06:53:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: "David S. Miller" <davem@rth.ninka.net>
Subject: Re: sendfile64() anyone? (was [RESEND] tuning linux for high network performance?)
Date: Thu, 24 Oct 2002 13:07:36 +0200
User-Agent: KMail/1.4.1
Cc: bert hubert <ahu@ds9a.nl>, netdev@oss.sgi.com,
       Kernel mailing list <linux-kernel@vger.kernel.org>
References: <200210231218.18733.roy@karlsbakk.net> <200210241230.46848.roy@karlsbakk.net> <1035456463.10555.7.camel@rth.ninka.net>
In-Reply-To: <1035456463.10555.7.camel@rth.ninka.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210241307.36134.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 October 2002 12:47, David S. Miller wrote:
> On Thu, 2002-10-24 at 03:30, Roy Sigurd Karlsbakk wrote:
> > Are there any plans of implementing sendfile64() or sendfile() support
> > for -D_FILE_OFFSET_BITS=64?
>
> This is old hat, and appears in every current vendor kernel I am
> aware of and is in 2.5.x as well.

then where can I find these patches? I cannot use 2.5, and I usually try to 
stick with an official kernel.

and - if this patch has been around all this time...

	why isn't it in the official kernel yet?

-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

