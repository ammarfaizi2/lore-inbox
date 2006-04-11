Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbWDKR7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWDKR7X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 13:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbWDKR7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 13:59:22 -0400
Received: from nproxy.gmail.com ([64.233.182.186]:19051 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750897AbWDKR7W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 13:59:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type;
        b=iIqWVMd4/Fncrmsh/aCTNXwUrQnZJ+HG3DA0TOxkOnxMf8/6FNgIT1h6g0eY7GqiHyov6+RWohEbW5pBISkAInlhlVywqCdRb9EopcZNkwyVbrFrj3tQGhlfIMVhNKizFkPHdo8RkQYjam1tp90JWObGVrp5sg9bO2ecIT3vxYU=
Message-ID: <443BEE76.9050407@gmail.com>
Date: Tue, 11 Apr 2006 19:59:18 +0200
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2.6.17-rc1-git4 1/1]  module.h: updated comments with a new
 license.
Content-Type: multipart/mixed;
 boundary="------------040303090205080208050301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040303090205080208050301
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

hi,


"Dual MIT/GPL" is also accepted (kernel/module.c), so updated comments.


-thanks-

-- 
Politicos de mierda, yo no soy un terrorista.

--------------040303090205080208050301
Content-Type: text/x-patch;
 name="licenses.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="licenses.diff"

diff -Nuar o/include/linux/module.h n/include/linux/module.h
--- o/include/linux/module.h	2006-03-31 22:58:37.000000000 +0200
+++ n/include/linux/module.h	2006-03-31 22:59:36.000000000 +0200
@@ -106,6 +106,8 @@
  *	"GPL and additional rights"	[GNU Public License v2 rights and more]
  *	"Dual BSD/GPL"			[GNU Public License v2
  *					 or BSD license choice]
+ *	"Dual MIT/GPL"			[GNU Public License v2
+ *					 or MIT license choice]
  *	"Dual MPL/GPL"			[GNU Public License v2
  *					 or Mozilla license choice]
  *


--------------040303090205080208050301--
