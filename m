Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbTENQUG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 12:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbTENQUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 12:20:06 -0400
Received: from tomts15.bellnexxia.net ([209.226.175.3]:21503 "EHLO
	tomts15-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262489AbTENQUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 12:20:05 -0400
Message-ID: <3EC26FB4.9080800@googgun.com>
Date: Wed, 14 May 2003 12:32:52 -0400
From: Ahmed Masud <masud@googgun.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4a) Gecko/20030401
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: Yoav Weiss <ml-lkml@unpatched.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: encrypted swap [was: The disappearing sys_call_table export.]
References: <20030514155727.GA16093@wohnheim.fh-wedel.de> <Pine.LNX.4.33.0305141211070.12082-100000@marauder.googgun.com> <20030514162323.GB16093@wohnheim.fh-wedel.de>
In-Reply-To: <20030514162323.GB16093@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
> On Wed, 14 May 2003 12:13:03 -0400, Ahmed Masud wrote:
> 
> 
> How do user *know* that root cannot simply bypass this security?
> 
> Root, god, what's the difference? ;-)

Hahah so true so true ... but all gods fall if their worshipers stop 
worshiping them ;-)

So ... there are ways. Root is only given this power because it is 
allowed that by the operating system kernel. It is always possible to 
shunt root out if the kernel chooses to do so.   We can actually 
construct environments where security officers != system administrators.


Ahmed.

