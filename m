Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbVDXPXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbVDXPXb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 11:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbVDXPXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 11:23:31 -0400
Received: from [220.226.8.89] ([220.226.8.89]:24968 "EHLO
	dacodecz.homelinux.org") by vger.kernel.org with ESMTP
	id S262339AbVDXPX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 11:23:29 -0400
Message-ID: <426BB912.6080801@dacodecz.homelinux.org>
Date: Sun, 24 Apr 2005 20:49:46 +0530
From: Ravi Poddar <ravi@dacodecz.homelinux.org>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: error reading following proc files ....
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear friends,

I got following errors while doing
ravi@dacodecz:~ # cat /proc/sys/fs/binfmt_misc/register
cat: /proc/sys/fs/binfmt_misc/register: Invalid argument
and
ravi@dacodecz:~ # cat /proc/sys/net/ipv4/route/flush
cat: /proc/sys/net/ipv4/route/flush: Invalid argument

any pointer regarding solving this problem would be grateful.
Ask if you need more information regarding this host.

TIY
Ravi Poddar

