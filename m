Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261350AbSITHl1>; Fri, 20 Sep 2002 03:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261395AbSITHl1>; Fri, 20 Sep 2002 03:41:27 -0400
Received: from web13302.mail.yahoo.com ([216.136.175.38]:12552 "HELO
	web13302.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261350AbSITHlZ>; Fri, 20 Sep 2002 03:41:25 -0400
Message-ID: <20020920074631.13390.qmail@web13302.mail.yahoo.com>
Date: Fri, 20 Sep 2002 09:46:31 +0200 (CEST)
From: =?iso-8859-1?q?Joerg=20Pommnitz?= <pommnitz@yahoo.com>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
 > They started and waited for 100,000 threads.
 > 
 > They did not have them all running at the same time. I think the
 > original post said something like "up to 50 at a time".

To quote Ulrich:

"Even on IA-32 with its limited address space and memory handling
 running 100,000 concurrent threads was no problem at all, creating
 and destroying the threads did not take more than two seconds."

It clearly states 100,000 CONCURRENT threads. So, it really seems to
work (not that I have the hardware to verify this claim).

Regards
  Jörg

=====
-- 
Regards
       Joerg


__________________________________________________________________

Gesendet von Yahoo! Mail - http://mail.yahoo.de
Möchten Sie mit einem Gruß antworten? http://grusskarten.yahoo.de
