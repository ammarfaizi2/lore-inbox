Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266199AbTBGSI6>; Fri, 7 Feb 2003 13:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266274AbTBGSI6>; Fri, 7 Feb 2003 13:08:58 -0500
Received: from hera.cwi.nl ([192.16.191.8]:8089 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S266199AbTBGSI4>;
	Fri, 7 Feb 2003 13:08:56 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 7 Feb 2003 19:18:36 +0100 (MET)
Message-Id: <UTC200302071818.h17IIaJ29578.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, brand@jupiter.cs.uni-dortmund.de
Subject: Re: syscall documentation
Cc: brand@eeyore.valparaiso.cl, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How about saying in CONFORMING TO

Done.

> And as this was during the current development series,
> what is the point of manpages anyway?

Historical documentation is also useful.
And the page contains a reference to hugetlbfs, which
is not obsolete.
And 2.4.20 contains the names (with ENOSYS) - no doubt
some people will wonder what they are.

Andries

[If you have recent man pages, try "man ttyslot"]
