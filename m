Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268429AbRG3IDS>; Mon, 30 Jul 2001 04:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268434AbRG3IDH>; Mon, 30 Jul 2001 04:03:07 -0400
Received: from web20005.mail.yahoo.com ([216.136.225.68]:50695 "HELO
	web20005.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S268430AbRG3ICz>; Mon, 30 Jul 2001 04:02:55 -0400
Message-ID: <20010730080303.45417.qmail@web20005.mail.yahoo.com>
Date: Mon, 30 Jul 2001 16:03:03 +0800 (CST)
From: =?gb2312?q?=D0=C2=20=D4=C2?= <xinyuepeng@yahoo.com>
Subject: A problem about the mkcramfs!
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

The mkcramfs uses a function "compress",which is
defined in 'zlib.h'.I feel it is a bit odd,which 
is defined as following:

 ZEXTERN int ZEXPORT compress OF((Bytef *dest,uLongf
*destLen,const Bytef *source, uLong sourceLen));

And I can't find its body,only find definition.I want
to get explanation.Thanks

Best regards:
              xinyuepeng



