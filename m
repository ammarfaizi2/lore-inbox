Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288284AbSAVQWx>; Tue, 22 Jan 2002 11:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288767AbSAVQWo>; Tue, 22 Jan 2002 11:22:44 -0500
Received: from p50859276.dip.t-dialin.net ([80.133.146.118]:40139 "EHLO
	minerva.local.lan") by vger.kernel.org with ESMTP
	id <S288284AbSAVQW2>; Tue, 22 Jan 2002 11:22:28 -0500
From: Martin Loschwitz <madkiss@madkiss.de>
Date: Tue, 22 Jan 2002 17:22:25 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18-pre4: undefined reference to `local symbols in discarded section .text.exit'
Message-ID: <20020122162225.GA7356@madkiss.de>
In-Reply-To: <20020122160603.GA7182@madkiss.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020122160603.GA7182@madkiss.de>
User-Agent: Mutt/1.3.26i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to tell you some things that could be important:

Debian Version: 3.0/Sid
Version of binutils: 2.11.92.0.12.3
Version of gcc: 2.95.4

After downgrading the binutils-package to version 2.11.92.0.10,
it works just fine.

-- 
-- Martin Loschwitz ---------------- hobbit.NeverAgain.DE --
-- Koernerstrasse 58 ---------- mail <madkiss@madkiss-de> --
-- 41747 Viersen ------------ http http://www.madkiss.de/ -- 
-- Germany ------------------------ irc Madkiss (IRC-Net) --
