Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316235AbSEVQrC>; Wed, 22 May 2002 12:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316238AbSEVQrB>; Wed, 22 May 2002 12:47:01 -0400
Received: from 61-218-106-194.HINET-IP.hinet.net ([61.218.106.194]:34247 "EHLO
	mgate1.csie.nctu.edu.tw") by vger.kernel.org with ESMTP
	id <S316235AbSEVQrB>; Wed, 22 May 2002 12:47:01 -0400
Subject: multithreaded device driver
From: lylai <lylai@csie.nctu.edu.tw>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 23 May 2002 00:47:42 +0800
Message-Id: <1022086063.9911.4.camel@chiayi.csie.nctu.edu.tw>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does linux kernel provide kernel level thread headers that I can use to
write a multithreaded device driver?

Do I need to program a device driver to be multithreaded to achieve
paralle I/O?

Thank you for your help.

