Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265403AbSJSAA4>; Fri, 18 Oct 2002 20:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265405AbSJSAA4>; Fri, 18 Oct 2002 20:00:56 -0400
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.226]:39050 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S265403AbSJSAA4>; Fri, 18 Oct 2002 20:00:56 -0400
Date: Fri, 18 Oct 2002 19:59:10 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: 2.5.43 : net/ipv4/ip_forward.c compile error
Message-ID: <Pine.LNX.4.44.0210181957310.9556-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  I haven't seen this posted on l-k yet (If I missed it, sorry in 
advance). While a 'make bzImage' on 2.5.43, I received the following 
error.

Regards,
Frank

net/ipv4/ip_forward.c: In function `ip_forward_finish':
net/ipv4/ip_forward.c:56: structure has no member named `key'
net/ipv4/ip_forward.c:56: structure has no member named `key'
make[2]: *** [net/ipv4/ip_forward.o] Error 1
make[1]: *** [net/ipv4] Error 2
make: *** [net] Error 2

