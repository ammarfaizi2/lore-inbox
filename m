Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264931AbTBJQJW>; Mon, 10 Feb 2003 11:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264940AbTBJQJW>; Mon, 10 Feb 2003 11:09:22 -0500
Received: from kestrel.vispa.uk.net ([62.24.228.12]:36359 "EHLO
	kestrel.vispa.uk.net") by vger.kernel.org with ESMTP
	id <S264931AbTBJQJV>; Mon, 10 Feb 2003 11:09:21 -0500
Message-ID: <3E47D057.4070205@walrond.org>
Date: Mon, 10 Feb 2003 16:16:23 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NFS root: New error messages in latest bk
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Latest bk 2.5;

Just booted with NFS root and noticed these new error messages in dmesg:

NFS: server cheating in read reply: count 4096 > recvd 1000
NFS: giant filename in readdir (len 0xcb2d2053)!

Anybody know what this means?

Andrew Walrond

