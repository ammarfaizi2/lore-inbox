Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261435AbSJUQTL>; Mon, 21 Oct 2002 12:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261437AbSJUQTL>; Mon, 21 Oct 2002 12:19:11 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:51881 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S261435AbSJUQTK>; Mon, 21 Oct 2002 12:19:10 -0400
Message-ID: <3DB42DAD.80704@kegel.com>
Date: Mon, 21 Oct 2002 09:39:09 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Rob Landley <landley@trommello.org>, boissiere@nl.linux.org
CC: Davide Libenzi <davidel@xmailserver.org>
Subject: re: Crunch time continues: the merge candidate list v1.1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please add epoll to your list.

Latest activity: the author changed the interface at Linus'
request, and made a bunch of fixes at Andrew Morton's request.

Current patch:
http://www.xmailserver.org/linux-patches/sys_epoll-2.5.44-0.3.diff
Home page:
http://www.xmailserver.org/linux-patches/nio-improve.html
Author: Davide Libenzi

Current status: ready to merge, I think...

- Dan

