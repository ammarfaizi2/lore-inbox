Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271501AbRHPG0k>; Thu, 16 Aug 2001 02:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271503AbRHPG0a>; Thu, 16 Aug 2001 02:26:30 -0400
Received: from web20008.mail.yahoo.com ([216.136.225.71]:44816 "HELO
	web20008.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S271501AbRHPG0T>; Thu, 16 Aug 2001 02:26:19 -0400
Message-ID: <20010816062632.69184.qmail@web20008.mail.yahoo.com>
Date: Thu, 16 Aug 2001 14:26:32 +0800 (CST)
From: =?gb2312?q?=D0=C2=20=D4=C2?= <xinyuepeng@yahoo.com>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!
   I am beginning learn to write a driver follow the
Book "Beginnng Linux programming(Second
Edition)".There is a example about char driver,I write
as that,but I can open device,but can't read from it.I
just copy some static data to user buffer as follow:
   copy_to_user(buf, schar_buffer, count)

Thanks,
xin



