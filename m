Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264358AbUFKWHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbUFKWHW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 18:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264360AbUFKWHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 18:07:22 -0400
Received: from webmail.cs.unm.edu ([64.106.20.39]:61653 "EHLO mail.cs.unm.edu")
	by vger.kernel.org with ESMTP id S264358AbUFKWHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 18:07:20 -0400
Message-ID: <40CA36AD.2060808@cs.unm.edu>
Date: Fri, 11 Jun 2004 16:48:13 -0600
From: Sushant Sharma <sushant@cs.unm.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: getting list of sk_buffs while calling sk_recvmsg
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *1BYuB6-0000tI-00*4GcJ7D/ukjg*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All
I want to know if we
can get hold of sk_receive_queue while
calling function sock_recvmsg in file net/socket.c.
Is it possible to get the list of sk_buffs through
sock->sk->sk_receive_queue in this function.

Thanks for help
Sushant

ps: please cc the reply to me

