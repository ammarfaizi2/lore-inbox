Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268595AbRGYRXR>; Wed, 25 Jul 2001 13:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268599AbRGYRW6>; Wed, 25 Jul 2001 13:22:58 -0400
Received: from cadmium.frontier.net ([199.45.141.22]:61188 "EHLO
	cadmium.frontier.net") by vger.kernel.org with ESMTP
	id <S268595AbRGYRWq>; Wed, 25 Jul 2001 13:22:46 -0400
Message-ID: <3B5EFFE3.5020206@bechtolt.com>
Date: Wed, 25 Jul 2001 11:20:35 -0600
From: Quinn Harris <quinn@bechtolt.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010721
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: VFS root dentry and super block question
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

If a dentry IS_ROOT (dentry->d_parent == dentry) does that imply 
dentry->d_sb->s_root == dentry and visa versa?
Just want to make sure I am not missing something.

Thanks
Quinn Harris

