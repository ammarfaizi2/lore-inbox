Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317430AbSFDLTp>; Tue, 4 Jun 2002 07:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317446AbSFDLTo>; Tue, 4 Jun 2002 07:19:44 -0400
Received: from web12708.mail.yahoo.com ([216.136.173.245]:1810 "HELO
	web12708.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S315461AbSFDLTn>; Tue, 4 Jun 2002 07:19:43 -0400
Message-ID: <20020604111944.34250.qmail@web12708.mail.yahoo.com>
Date: Tue, 4 Jun 2002 04:19:44 -0700 (PDT)
From: Hossein Mobahi <hmobahi@yahoo.com>
Subject: problem with <asm/semaphore.h>
To: linux-kernel@vger.kernel.org
Cc: linux-c-programming@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I compiled the following code with gcc under Redhat
7.2 :

#include <asm/semaphore.h>
main()
{
    struct semaphore sum;
}

It doesn't compile, saying "storage size of `sem'
isn't known".
Please guide me how to fix it.

Sincerely

--Hossein Mobahi


__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com
