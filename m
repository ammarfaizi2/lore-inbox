Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315779AbSHaD5i>; Fri, 30 Aug 2002 23:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315870AbSHaD5i>; Fri, 30 Aug 2002 23:57:38 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:22534
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S315779AbSHaD5h>; Fri, 30 Aug 2002 23:57:37 -0400
Date: Fri, 30 Aug 2002 21:01:58 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Volker Kuhlmann <list0570@paradise.net.nz>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] make localconfig
Message-ID: <20020831040158.GB457@matchmail.com>
Mail-Followup-To: Thunder from the hill <thunder@lightweight.ods.org>,
	Volker Kuhlmann <list0570@paradise.net.nz>,
	linux-kernel@vger.kernel.org
References: <20020825110251.GF11740@paradise.net.nz> <Pine.LNX.4.44.0208250515250.3234-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208250515250.3234-100000@hawkeye.luckynet.adm>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2002 at 05:17:24AM -0600, Thunder from the hill wrote:
> Hi,
> 
> On Sun, 25 Aug 2002, Volker Kuhlmann wrote:
> > Even with code noone seems to have taken heed. The code has been
> > available for ages. I think it's very useful.
> 
> I think you're talking about different code.
> 
> > gunzip </proc/config.gz gives you the config of the running kernel,
> 
> What if the current kernel is some allmodconfig, and you don't want that, 
> for some reason? And by the way, that's not related to the transition I 
> mentioned. If you want that, just go and do make allmodconfig.
> 
> > make cloneconfig
> 
> Why not make oldconfig?

Because then you'd just be comparing the current to the default config, not
much gained there...
