Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275003AbRJJHOB>; Wed, 10 Oct 2001 03:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275021AbRJJHNv>; Wed, 10 Oct 2001 03:13:51 -0400
Received: from web11905.mail.yahoo.com ([216.136.172.189]:33028 "HELO
	web11905.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S275003AbRJJHNm>; Wed, 10 Oct 2001 03:13:42 -0400
Message-ID: <20011010071413.53845.qmail@web11905.mail.yahoo.com>
Date: Wed, 10 Oct 2001 00:14:13 -0700 (PDT)
From: Kirill Ratkin <kratkin@yahoo.com>
Subject: kdb requires kallsyms
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0110092236210.1305-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. 

I've trouble with kdb. I've patched my kernel (stable
2.4.10) and tried to make kernel with kdb (from SGI)
and I see :
/bin/sh: /sbin/kallsyms: No such file or directory
make[1]: *** [kallsyms] error 127

Where can I find this kallsyms?

Regards,





__________________________________________________
Do You Yahoo!?
Make a great connection at Yahoo! Personals.
http://personals.yahoo.com
