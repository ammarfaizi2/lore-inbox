Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317345AbSHHSMW>; Thu, 8 Aug 2002 14:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317448AbSHHSMW>; Thu, 8 Aug 2002 14:12:22 -0400
Received: from web12902.mail.yahoo.com ([216.136.174.69]:17163 "HELO
	web12902.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317345AbSHHSMU>; Thu, 8 Aug 2002 14:12:20 -0400
Message-ID: <20020808181602.27210.qmail@web12902.mail.yahoo.com>
Date: Thu, 8 Aug 2002 11:16:02 -0700 (PDT)
From: Tom Sanders <developer_linux@yahoo.com>
Subject: Layered Driver Support in Linux ?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does Linux support layered drivers ?

I want to write a driver that will take requests from
the applications and will pass them on to underlying
SD disk driver. For this I need to map open, close,
read, write, ioctl etc entry points to corresponding
functions of the underlying driver.

Pointer to any info would be appreciated.

Thanks,
Tom


__________________________________________________
Do You Yahoo!?
HotJobs - Search Thousands of New Jobs
http://www.hotjobs.com
