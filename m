Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268614AbRHPBWG>; Wed, 15 Aug 2001 21:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268617AbRHPBVz>; Wed, 15 Aug 2001 21:21:55 -0400
Received: from [213.97.137.182] ([213.97.137.182]:9234 "HELO
	iceberg.activanet.net") by vger.kernel.org with SMTP
	id <S268614AbRHPBVr>; Wed, 15 Aug 2001 21:21:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Eduardo =?iso-8859-1?q?Cort=E9s=20?= <the_beast@softhome.net>
To: linux-kernel@vger.kernel.org
Subject: limit cpu
Date: Thu, 16 Aug 2001 03:21:58 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010816012150Z268614-760+2237@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
i want to know if linux can limit the max cpu usage (not cpu time) per user, 
like freebsd login classes. I see /etc/security/limits.conf and ulimit from 
bash, but they limit the max cpu time, not de max cpu usage (%cpu). 
Thanks.
