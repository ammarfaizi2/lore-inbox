Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262313AbTCIAI5>; Sat, 8 Mar 2003 19:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262317AbTCIAI5>; Sat, 8 Mar 2003 19:08:57 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:37045 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP
	id <S262313AbTCIAI5>; Sat, 8 Mar 2003 19:08:57 -0500
Message-ID: <3E6A888D.3040008@cox.net>
Date: Sat, 08 Mar 2003 17:19:25 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.3b) Gecko/20030215
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jean-Denis Girard <jd-girard@esoft.pf>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.64: kernel BUG at include/linux/dcache.h
References: <3E6A695B.6070006@esoft.pf>
In-Reply-To: <3E6A695B.6070006@esoft.pf>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Denis Girard wrote:
> Mar  7 22:02:07 taina kernel: kernel BUG at include/linux/dcache.h:266!
> Mar  7 22:02:07 taina kernel: invalid operand: 0000
> Mar  7 22:02:07 taina kernel: CPU:    0
> Mar  7 22:02:07 taina kernel: EIP:    0060:[sysfs_remove_dir+29/323]    
> Not tainted

Patrick Mochel posted a patch to solve this problem a couple of days 
ago. Check the archives.

