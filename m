Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269221AbRHBXCQ>; Thu, 2 Aug 2001 19:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269219AbRHBXCG>; Thu, 2 Aug 2001 19:02:06 -0400
Received: from host213-1-80-234.btinternet.com ([213.1.80.234]:36100 "EHLO
	Wasteland") by vger.kernel.org with ESMTP id <S269203AbRHBXB4>;
	Thu, 2 Aug 2001 19:01:56 -0400
Message-Id: <m15SRKI-000CbBC@Wasteland>
Content-Type: text/plain; charset=US-ASCII
From: Matthew M <matthew.macleod@btinternet.com>
To: astor@fast.no
Subject: [PATCH] crypto fix for 2.4.7
Date: Thu, 2 Aug 2001 23:52:19 +0100
X-Mailer: KMail [version 1.2.9]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch fixes crypto support in recent kernels, I know it works with 
2.4.7, but I have had no time to test with other kernel versions > 2.4.3. 
Should do though, so please try and tell. Remember, its not the "official" 
patch, just a test!
 
(It's a "full" patch for those without any crypto support, zcat 
../patch-int-2.4.7.gz | patch -p2 in the source folder.)

http://www.mattm.f9.co.uk/cryptopatch/patch-int-2.4.7.gz

thx people. feedback would be good, my first patch ;)
 
-- 
*matt* 

