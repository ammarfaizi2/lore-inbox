Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313023AbSDGKGU>; Sun, 7 Apr 2002 06:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313025AbSDGKGT>; Sun, 7 Apr 2002 06:06:19 -0400
Received: from [151.200.199.53] ([151.200.199.53]:51986 "EHLO fc.Capaccess.org")
	by vger.kernel.org with ESMTP id <S313023AbSDGKGS>;
	Sun, 7 Apr 2002 06:06:18 -0400
Message-id: <fc.00858412003a56ca00858412003a56ca.3a56ed@Capaccess.org>
Date: Sun, 07 Apr 2002 06:05:25 -0400
Subject: forth interpreter as kernel module
To: linux-kernel@vger.kernel.org
Cc: davidw@dedasys.com
From: "Rick A. Hohensee" <rickh@Capaccess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Interesting. That 1998 file for making a /proc scripting thing,
what else has it been used for? 

Sometime around June 2001 I released a 3-stack Forthlike language 
embedded in a Linux kernel. The implementation is quite different 
than yours. In H3rL, Hohensee's 3-ring Linux, H3sm, Hohensee's 3-stack
machine, runs as a kernel daemon with regular user interaction via
a vt. I use vt1 on this box. 

I would also call your attention to upforth. H3rL, H3sm and upforth
are in ftp://linux01.gwdg.de/pub/cLIeNUX/interim

Rick Hohensee

