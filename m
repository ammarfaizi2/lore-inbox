Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316113AbSHOGvv>; Thu, 15 Aug 2002 02:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316601AbSHOGvv>; Thu, 15 Aug 2002 02:51:51 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316113AbSHOGvv>; Thu, 15 Aug 2002 02:51:51 -0400
Message-ID: <3D5B5066.8070608@zytor.com>
Date: Wed, 14 Aug 2002 23:55:34 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: David Lang <david.lang@digitalinsight.com>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org
Subject: Re: [patch 4/21] fix ARCH_HAS_PREFETCH
References: <20020814204556.GA7440@alpha.home.local> <Pine.LNX.4.44.0208141551020.14879-100000@dlang.diginsite.com> <20020815064404.GC7445@alpha.home.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> 
> Moreover, some people complain about the fact that gcc doesn't optimize
> everything because of people using loops for delays. If we provide convenient
> ways to help the user tell gcc when not to optimize, gcc could optimize
> everything possible by default.
> 

Well, again, such ways already exist.

	-hpa


