Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284136AbRLRQDP>; Tue, 18 Dec 2001 11:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284138AbRLRQDF>; Tue, 18 Dec 2001 11:03:05 -0500
Received: from m788-mp1-cvx1b.edi.ntl.com ([62.253.11.20]:19182 "EHLO
	pinkpanther.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S284136AbRLRQCu>; Tue, 18 Dec 2001 11:02:50 -0500
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200112181458.fBIEwAr15822@pinkpanther.swansea.linux.org.uk>
Subject: Re: Turning off nagle algorithm in 2.2.x and 2.4.x kernels?
To: Zameer.Ahmed@gs.com (Ahmed, Zameer)
Date: Tue, 18 Dec 2001 14:58:10 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <FBC7494738B7D411BD7F00902798761908BFF190@gsny49e.ny.fw.gs.com> from "Ahmed, Zameer" at Dec 17, 2001 04:03:15 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> and 2.4.x kernels? For the same custom app used under Solaris and Linux.
> Turning off nagle algorithm boosted perf on Solaris, I tried commenting out

man setsockopt (Linux and Solaris)


