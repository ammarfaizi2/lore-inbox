Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316857AbSHXXhi>; Sat, 24 Aug 2002 19:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316860AbSHXXhi>; Sat, 24 Aug 2002 19:37:38 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:11237 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316857AbSHXXhi>; Sat, 24 Aug 2002 19:37:38 -0400
Message-ID: <3D67FDB2.60404@t-online.de>
Date: Sat, 24 Aug 2002 23:42:10 +0200
From: chris.schwemmer@t-online.de (Chris Schwemmer)
User-Agent: Mozilla/5.0 (Windows; U; Win98; de-AT; rv:1.0.0) Gecko/20020530
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Possible bug in 2.4.19 ps/2 handling?
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I already posted 3 days ago I had severe trouble getting my mouse 
going on my new system... now I recompiled the whole system with gcc 
2.95.3 instead of 3.2 and switched back to kernel 2.4.18 and that solved 
the problem. Neither using gcc 3.2 with kernel 2.4.18 nor using gcc 
2.95.3 with kernel 2.4.19 did work. Both times pressing numlock killed 
the mouse and restarting gpm afterwards killed the keyboard.
Just wanted to tell you in case this is indeed a kernel problem...

Chris

