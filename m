Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317432AbSFHThA>; Sat, 8 Jun 2002 15:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317433AbSFHTg7>; Sat, 8 Jun 2002 15:36:59 -0400
Received: from mta3.srv.hcvlny.cv.net ([167.206.5.9]:26324 "EHLO
	mta3.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S317432AbSFHTg6>; Sat, 8 Jun 2002 15:36:58 -0400
Date: Sat, 08 Jun 2002 14:15:10 -0400
From: jay <jbeatty@optonline.net>
Subject: rpm --rebuild fails on 2.5.20
To: linux kernel <linux-kernel@vger.kernel.org>
Message-id: <3D0249AE.4070902@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to use rpm to rebuild a src.rpm, it gives a Segmentation 
fault on 2.5.20. Works on 2.5.18 and 2.4.18.

rpm -vvvvvv --rebuild ORBit2*
Segmentation fault


Some small src.rpm files work, e.g. filesystem-2.1.6-4.src.rpm, but not all.

jay

