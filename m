Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317622AbSIEOvw>; Thu, 5 Sep 2002 10:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317623AbSIEOvw>; Thu, 5 Sep 2002 10:51:52 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:39430 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S317622AbSIEOvw>; Thu, 5 Sep 2002 10:51:52 -0400
Date: Thu, 5 Sep 2002 16:56:10 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Mike Isely <isely@pobox.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       "Henning P. Schmiedehausen" <hps@intermeta.de>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.20-pre5-ac2: Promise Controller LBA48 DMA fixed
Message-ID: <20020905145610.GW24323@louise.pinerecords.com>
References: <200209051435.g85EZZ6H022915@pincoya.inf.utfsm.cl> <Pine.LNX.4.44.0209050937100.10556-100000@grace.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209050937100.10556-100000@grace.speakeasy.net>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
X-Uptime: 10 days, 7:39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But in the future, if I post more fixes to the IDE driver (probably 
> won't), I'll sanitize as I go along.

>From what Andre said in the past I've gathered he's very much ok with
code sanitizing and cleanups... Knock yourself out if you please.

> I find it amusing that a post from me which describes evidence of
> completely broken Promise controller DMA goes unresponded to, yet there
> are concerns about whether to spell code as "a != b" or "!(a == b)".

Well, your patch is obviously correct -- there's not much to comment on.

T.
