Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267165AbTAPQXQ>; Thu, 16 Jan 2003 11:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267174AbTAPQXQ>; Thu, 16 Jan 2003 11:23:16 -0500
Received: from smtp1.us.dell.com ([143.166.148.133]:47498 "EHLO
	smtp1.us.dell.com") by vger.kernel.org with ESMTP
	id <S267165AbTAPQXO>; Thu, 16 Jan 2003 11:23:14 -0500
Date: Thu, 16 Jan 2003 10:14:39 -0600 (CST)
From: Robert Macaulay <robert_macaulay@dell.com>
X-X-Sender: robert@ping.us.dell.com
Reply-To: Robert Macaulay <robert_macaulay@dell.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.57 IO slowdown with CONFIG_PREEMPT enabled
In-Reply-To: <20030116035109.64d1ef97.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0301161007380.24617-100000@ping.us.dell.com>
X-Complaints-to: /dev/null
X-Apparently-From: mars
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2003, Andrew Morton wrote:
> I'd appreciate it if you could take a closer look at the mysterious
> self-reverting .config, please.  See if you can work out what is causing it,
> tell me how you're rebooting (reboot -f?  -fn?  Big Red Button?) and whether
> the offending file is on the root filesystem, etc.

Seemed to vanish with 2.5.58. It was non-root filesystem, with a clean 
'reboot' shutdown. 

2.5.58 performed the same as 2.5.57 with regards to preemption on, off, 
and patched.

r

