Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290593AbSDMRCL>; Sat, 13 Apr 2002 13:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290797AbSDMRCK>; Sat, 13 Apr 2002 13:02:10 -0400
Received: from [212.57.170.40] ([212.57.170.40]:8710 "EHLO zzz.zzz")
	by vger.kernel.org with ESMTP id <S290593AbSDMRCJ>;
	Sat, 13 Apr 2002 13:02:09 -0400
Date: Sat, 13 Apr 2002 22:47:43 +0600
From: Denis Zaitsev <zzz@cd-club.ru>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: FIXED_486_STRING ?
Message-ID: <20020413224743.A13355@natasha.zzz.zzz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the state of the FIXED_486_STRING macro?  It is used once thru
all the kernel tree - in include/asm-i386/string.h - and it seems that
its role is to disable a usage of string-486.h completely...  Am I
right?
