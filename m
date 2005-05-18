Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262201AbVEROO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbVEROO3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 10:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVERONi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 10:13:38 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:3712 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S262193AbVEROLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 10:11:36 -0400
Message-ID: <428B4D14.2030104@ammasso.com>
Date: Wed, 18 May 2005 09:11:32 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Reply-To: linux-kernel@vger.kernel.org
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: linux.bkbits.net question: mapping cset to kernel version?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Given a particular file and a particular bitkeeper revision for the file, how can I tell 
which version of the kernel incorporated that changeset?

In particular, I want to know about revision 1.65 of mm/rmap.c, which can be seen at 
http://linux.bkbits.net:8080/linux-2.6/diffs/mm/rmap.c@1.65?nav=index.html|src/|src/mm|hist/mm/rmap.c

I want to know what the first version of Linux is to incorporate that change.

And please don't tell me to do a diff on all the 2.6 versions, because that's not efficient.

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13
