Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271756AbRHRBAi>; Fri, 17 Aug 2001 21:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271757AbRHRBA1>; Fri, 17 Aug 2001 21:00:27 -0400
Received: from cr803443-a.flfrd1.on.wave.home.com ([24.156.64.178]:20099 "EHLO
	fxian.jukie.net") by vger.kernel.org with ESMTP id <S271756AbRHRBAG>;
	Fri, 17 Aug 2001 21:00:06 -0400
Date: Fri, 17 Aug 2001 21:00:27 -0400 (EDT)
From: Feng Xian <fxian@fxian.jukie.net>
X-X-Sender: <fxian@tiger>
To: <linux-kernel@vger.kernel.org>
Subject: is there a way to let kernel to skip one region of physical memory?
Message-ID: <Pine.LNX.4.33.0108172058160.5581-100000@tiger>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, all,

I have a question. say I have 128M physical memory, but for some reason, I
don't want the kernel to use a little part of that memory, e.g. physical
address from 4M to 5M. is there a way to let the kernel to do something
like this? thanks in advance.

Alex

-- 
        Feng Xian
   _o)     .~.      (o_
   /\\     /V\      //\
  _\_V    // \\     V_/_
         /(   )\
          ^^-^^
           ALEX

