Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316545AbSHNLKY>; Wed, 14 Aug 2002 07:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316573AbSHNLKY>; Wed, 14 Aug 2002 07:10:24 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:17924 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S316545AbSHNLKX>; Wed, 14 Aug 2002 07:10:23 -0400
Message-Id: <200208141109.g7EB9hp15788@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: stas.orel@mailcity.com, Stas Sergeev <stssppnn@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] New PC-Speaker driver
Date: Wed, 14 Aug 2002 14:06:38 -0200
X-Mailer: KMail [version 1.3.2]
References: <3D450B0F.4090901@yahoo.com>
In-Reply-To: <3D450B0F.4090901@yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 July 2002 07:29, Stas Sergeev wrote:
> For all those people who still
> don't have a sound card I want to
> introduce a pc-speaker driver.
> There were some other pc-speaker
> drivers floating over the net, but
> AFAIK no one is really finished and
> usable.
> My driver is originally based on
> Michael Beck and David Woodhouse
> driver, but it is havily reworked
> and pretends to be 100% OSS compatible
> producing nearly the best sound
> one can ever get from pc-speaker.
> Well, there is (currently) no
> intention to get it into the mainstream
> kernel so don't treat it too seriously.
> However any comments or bugreports are
> appreciated.
>
> The latest patch for 2.4.18 kernel
> is available here:
> http://www.geocities.com/stssppnn/pcsp.html

Tested. Works for playing MP3s.
--
vda
