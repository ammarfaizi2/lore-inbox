Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265934AbUAKSVr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 13:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUAKSVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 13:21:47 -0500
Received: from adsl-67-114-19-185.dsl.pltn13.pacbell.net ([67.114.19.185]:31440
	"EHLO bastard.smallmerchant.com") by vger.kernel.org with ESMTP
	id S265934AbUAKSVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 13:21:46 -0500
Message-ID: <40019435.8080203@tupshin.com>
Date: Sun, 11 Jan 2004 10:21:41 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla Thunderbird 0.5a (20031216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: The NeverGone <never@delfin.klte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UML (user-mode-linux) kernel-2.6.x
References: <Pine.LNX.4.58.0401111555360.3557@localhost>
In-Reply-To: <Pine.LNX.4.58.0401111555360.3557@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The NeverGone wrote:

>NET4: Linux TCP/IP 1.0 for NET4.0
>IP: routing cache hash table of 512 buckets, 4Kbytes
>TCP: Hash tables configured (established 2048 bind 4096)
>Linux IP multicast router 0.06 plus PIM-SM
>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
>VFS: Mounted root (ext2 filesystem) readonly.
>I'm tracing myself and I can't get out
>
>===== uml-log end =====
>
>... and here dead.
>Please correct this error.
>
>Thx:
>Kurucz "The NeverGone" Istvan :)
>  
>
http://usermodelinux.org/

Look at the second item called:
FAQ: "I'm tracing myself and I can't get out"

There is an associated patch which needs to be applied to the UML 
*guest* when running on a 2.6 host.

-Tupshin


