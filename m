Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbUBWVn7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 16:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbUBWVn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 16:43:58 -0500
Received: from mail.radiozet.pl ([194.242.39.2]:48882 "EHLO
	mail.sto-procent.art.pl") by vger.kernel.org with ESMTP
	id S262046AbUBWVn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 16:43:57 -0500
Message-ID: <403A72B9.8020207@sto-procent.art.pl>
Date: Mon, 23 Feb 2004 22:38:01 +0100
From: boka <boka@sto-procent.art.pl>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: compaq dl380 server with kernel 2.6.3 - errors during boot process
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I have Slackware 9.1 (with all erratas) installed on compaq dl380. I 
have compiled 2.6.3 kernel and machine can not boot.

 From screen:

...
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buchets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17

and boot process stops here.

I tryed with -mm3 patches - same result.

Here is my .config file:

http://www.boka.art.pl/filez/config-2.6.3-mm3

greetz
boka
