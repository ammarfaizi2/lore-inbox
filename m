Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316465AbSH0P4j>; Tue, 27 Aug 2002 11:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316491AbSH0P4j>; Tue, 27 Aug 2002 11:56:39 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:2288 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S316465AbSH0P4i>; Tue, 27 Aug 2002 11:56:38 -0400
From: Richard.Zidlicky@stud.informatik.uni-erlangen.de
Date: Tue, 27 Aug 2002 18:00:43 +0200 (MEST)
Message-Id: <200208271600.SAA17957@faui02b.informatik.uni-erlangen.de>
To: davem@redhat.com, benh@kernel.crashing.org
Subject: Re: readsw/writesw readsl/writesl
Cc: linux-kernel@vger.kernel.org
X-Sun-Charset: US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




[snip]

> ...... However, if we decide to go the way
> you describe, the we should probably also provide the raw_{in,out}*
> ones.

carefull, m68k already has them for other purposes. Original intention
was that raw_{in,out} should never be used outside architecture specific 
stuff anyway.

Richard

 
