Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263749AbUCPJdY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 04:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263748AbUCPJdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 04:33:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10723 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263749AbUCPJb2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 04:31:28 -0500
Message-ID: <4056B0DB.9020008@pobox.com>
Date: Tue, 16 Mar 2004 02:46:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Greg KH <greg@kroah.com>,
       bos@serpentine.com, Andrew Morton <akpm@osdl.org>,
       linux-raid <linux-raid@vger.kernel.org>
Subject: [PATCH] klibc update
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Too big to post,

http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.5-rc1-klibc1.patch.bz2
	or
bk://kernel.bkbits.net/jgarzik/klibc-2.5

IIRC, this is:  my update of Bryan O'Sullivan's update of Greg KH's 
update of my merge of hpa's and viro's hacking :)

WRT overall klibc merge:  when it can do md RAID autorun, it's 
mergeable.  And didn't somebody write a tiny mdctl program...

	Jeff



