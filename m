Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264805AbSKEKuG>; Tue, 5 Nov 2002 05:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264808AbSKEKuF>; Tue, 5 Nov 2002 05:50:05 -0500
Received: from fou-fw.sts.no ([194.248.153.2]:52228 "EHLO
	station3.kontor.itsopen.no") by vger.kernel.org with ESMTP
	id <S264805AbSKEKuD>; Tue, 5 Nov 2002 05:50:03 -0500
Subject: Re: framebuffer: 2.4.19 - geforce4 ti 4200
From: Nils Petter Vaskinn <nils.petter.vaskinn@itsopen.net>
To: michael@kummer.cc,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0211051127080.244-100000@epo>
References: <Pine.LNX.4.44.0211051127080.244-100000@epo>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-4) 
Date: 05 Nov 2002 11:57:47 +0100
Message-Id: <1036493867.1551.11.camel@station3>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-05 at 11:28, Michael Kummer wrote:
> does 2.4.19 support the geforce4 ti 4200 card (fb console)
> 
> my old tnt2 works but i cant get the new gforce4 to work (blank screen
> when booting)
> 
> -- 
> best regards
> 

I have successfully used the vesafb with a geforce4 based card on 2.4.18
kernel, so I assume it should work on 2.4.19 too unless your hardware
does something nasty

AFAIK there is no accelerated fb driver for geforce4 in 2.4

linux-fbdev-devel@lists.sourceforge.net mailinglist can probably provide
more answers

br
Nils Petter Vaskinn
