Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277402AbRJLHwE>; Fri, 12 Oct 2001 03:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277564AbRJLHvx>; Fri, 12 Oct 2001 03:51:53 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:12473 "EHLO
	mailout04.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S277402AbRJLHvh>; Fri, 12 Oct 2001 03:51:37 -0400
Message-ID: <3BC6A0F4.E0046B2E@sebastian-bergmann.de>
Date: Fri, 12 Oct 2001 09:51:16 +0200
From: Sebastian Bergmann <sb@sebastian-bergmann.de>
Organization: www.sebastian-bergmann.de
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.11+2.4.12: drivers/net/8139too.c and GCC 3.0.1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-KorrNews: Used
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Just to let you know, too:

  I get an 'Internal compiler error' with GCC 3.0.1 when trying to 
  compile drivers/net/8139too.c of kernel version 2.4.11 and 2.4.12.

  A bug report exists on http://gcc.gnu.org/cgi-bin/gnatsweb.pl, its ID
  is c/4531.

-- 
  Sebastian Bergmann
  http://sebastian-bergmann.de/                 http://phpOpenTracker.de/

  Did I help you? Consider a gift: http://wishlist.sebastian-bergmann.de/
