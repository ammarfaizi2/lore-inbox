Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315919AbSIIAo6>; Sun, 8 Sep 2002 20:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315923AbSIIAo6>; Sun, 8 Sep 2002 20:44:58 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:5060 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S315919AbSIIAo5>;
	Sun, 8 Sep 2002 20:44:57 -0400
Message-ID: <1031532577.3d7bf021de52a@kolivas.net>
Date: Mon,  9 Sep 2002 10:49:37 +1000
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Subject: Supermount added to performance patches (-ck) for stable kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



As my merged performance patches [O(1)+batch,Preempt,Low latency,-AA vm] are
aimed at the desktop user I've found many people have requested supermount as an
option. I have now added supermount support. Otherwise, ck7 is unchanged from
ck6, so unless you want supermount there is no point upgrading.

Get it here as 2.4.19-ck7:

http://kernel.kolivas.net

Cheers,
Con Kolivas

Please feel free to contact me with any questions, comments or suggestions and
don't forget to cc me to ensure I see your email.
