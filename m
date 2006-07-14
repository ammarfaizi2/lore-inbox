Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945918AbWGNXo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945918AbWGNXo1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 19:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945919AbWGNXo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 19:44:27 -0400
Received: from mta4.srv.hcvlny.cv.net ([167.206.4.199]:38602 "EHLO
	mta4.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1945918AbWGNXo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 19:44:27 -0400
Date: Fri, 14 Jul 2006 19:44:25 -0400
From: Michael Lindner <mikell@optonline.net>
Subject: Re: PROBLEM: epoll_wait() returns wrong events for EOF with EPOLLOUT
In-reply-to: <Pine.LNX.4.64.0607141535070.2463@alien.or.mcafeemobile.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <200607141944.26010.mikell@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <200607141518.58635.mikell@optonline.net>
 <Pine.LNX.4.64.0607141535070.2463@alien.or.mcafeemobile.com>
User-Agent: KMail/1.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri July 14 2006 6:38 pm, Davide Libenzi wrote:
> Please take a look at the POSIX docs for poll(2).

My apologies - I had read very incomplete/misleading documentation - that'll 
learn me.

So there's just "4. There has been no error on the FD, so why return 
EPOLLERR?"

-- 
Michael Lindner
