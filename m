Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261955AbVDVOzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbVDVOzY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 10:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVDVOzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 10:55:24 -0400
Received: from mail.ima.umn.edu ([128.101.10.8]:24979 "EHLO mail.ima.umn.edu")
	by vger.kernel.org with ESMTP id S261955AbVDVOyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 10:54:54 -0400
Message-ID: <4269103D.1000503@ima.umn.edu>
Date: Fri, 22 Apr 2005 09:54:53 -0500
From: Eric Harvieux <eric@ima.umn.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040530 Debian/1.6-6.backports.org.1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Irix NFS Server Problems - Ever Resolved?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have recently run into problems with 2.6 NFS clients accessing Irix 
servers. After extensive searching, I found the problem referred to on 
the kernel mailing list, in this thread:

http://kerneltrap.org/mailarchive/1/message/19372/thread

I could not find any other discussion of this issue and was wondering if 
there has been any further work done to write a patch for this issue? 
This bug definitely breaks 2.6 NFS clients, while 2.4 clients works fine.

Thanks,
-Eric

-- 
==============================================
Eric Harvieux       | eric@ima.umn.edu
           http://www.ima.umn.edu/
==============================================
Institute for Mathematics and its Applications
University of Minnesota
==============================================
