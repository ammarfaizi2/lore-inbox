Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265213AbUBOWzk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 17:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265215AbUBOWzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 17:55:40 -0500
Received: from w130.z209220038.sjc-ca.dsl.cnc.net ([209.220.38.130]:48623 "EHLO
	mail.inostor.com") by vger.kernel.org with ESMTP id S265213AbUBOWzj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 17:55:39 -0500
Message-ID: <402FFA91.5020206@inostor.com>
Date: Sun, 15 Feb 2004 15:02:41 -0800
From: Shesha Sreenivasamurthy <shesha@inostor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "'redhat-ppp-list@redhat.com'" <redhat-ppp-list@redhat.com>,
       "'kernelnewbies@nl.linux.org'" <kernelnewbies@nl.linux.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Kernel Highmemory problem
References: <01C3E716.AA1B04A0.vanitha@agilis.st.com.sg>
In-Reply-To: <01C3E716.AA1B04A0.vanitha@agilis.st.com.sg>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,
I have a driver that currently does not support highmem. i.e., no "kmap" 
& "kunmap" is being implemented. Now we want to support more than 896MB 
RAM. What is the best approach to tackle the situation? Any ideas is 
highly valued.

Thanks
Shesha

