Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262873AbVG2XvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbVG2XvR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 19:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbVG2Xs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 19:48:58 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:59152 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S262936AbVG2Xsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 19:48:43 -0400
Message-ID: <42EAC06A.5080807@gentoo.org>
Date: Sat, 30 Jul 2005 00:48:58 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050723)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: zaitcev@redhat.com, rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: percpu_modalloc oops when loading netfilter modules
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete, Rusty,

I found a snippet of a previous discussion of yours here:

http://www.ussg.iu.edu/hypermail/linux/kernel/0408.3/2901.html
http://www.ussg.iu.edu/hypermail/linux/kernel/0409.0/0768.html

Did anything become of this issue?

A Gentoo user has reported what appears to be the same problem on 2.6.12:
http://bugs.gentoo.org/show_bug.cgi?id=97006

Thanks,
Daniel
