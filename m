Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317401AbSFRNXQ>; Tue, 18 Jun 2002 09:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317402AbSFRNXP>; Tue, 18 Jun 2002 09:23:15 -0400
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49]:9183 "EHLO
	scaup.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S317401AbSFRNXO>; Tue, 18 Jun 2002 09:23:14 -0400
Date: Tue, 18 Jun 2002 09:24:57 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.21 IDE 91
Message-ID: <20020618132457.GA30830@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Is it reproducible?   

> tiobench had a similar livelock in 2.5.19, 2.5.19 + 2 versions of
> wli's lazy-buddy allocator, 2.5.20, 2.5.21

2.5.22 completes all the tests, including tiobench.  :)

-- 
Randy Hron
http://home.earthlink.net/~rwhron/

