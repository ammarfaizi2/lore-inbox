Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281530AbRKZI6l>; Mon, 26 Nov 2001 03:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281526AbRKZI6b>; Mon, 26 Nov 2001 03:58:31 -0500
Received: from web12806.mail.yahoo.com ([216.136.174.41]:51216 "HELO
	web12806.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S281527AbRKZI6T>; Mon, 26 Nov 2001 03:58:19 -0500
Message-ID: <20011126085818.49348.qmail@web12806.mail.yahoo.com>
Date: Mon, 26 Nov 2001 00:58:18 -0800 (PST)
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: PATCH: gcc3.0.2 workaround for 8139too
To: linux-kernel@vger.kernel.org
In-Reply-To: <slrna02427.3v.reneb@orac.aais.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc 3.0.0, 3.0.1, 3.0.2 needs this patch:

http://gcc.gnu.org/cgi-bin/gnatsweb.pl?cmd=view%20audit-trail&pr=4529&database=gcc

to compile the kernel and the 8139too.c nic driver.

-lt




=====
--

__________________________________________________
Do You Yahoo!?
Yahoo! GeoCities - quick and easy web site hosting, just $8.95/month.
http://geocities.yahoo.com/ps/info1
