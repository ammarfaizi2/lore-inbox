Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265401AbUAZAY4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 19:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265403AbUAZAYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 19:24:55 -0500
Received: from CPE-65-30-34-80.kc.rr.com ([65.30.34.80]:65408 "EHLO
	cognition.home.hanaden.com") by vger.kernel.org with ESMTP
	id S265401AbUAZAYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 19:24:48 -0500
Message-ID: <40145E3A.5050704@hanaden.com>
Date: Sun, 25 Jan 2004 18:24:26 -0600
From: hanasaki <hanasaki@hanaden.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NFS rpc and stale handles on 2.6.x servers
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The below is being reported, on and off, when hitting nfs-kernel-servers 
running on 2.6.0 and 2.6.1  Could someone tell me if this is smoe bug or 
what?  Thanks
	RPC request reserved 0 but used 124

Debian sarge
nfs-kernel-server
am-untils
nfsv3 over tcp


