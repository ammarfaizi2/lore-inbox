Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311936AbSDAQAo>; Mon, 1 Apr 2002 11:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311948AbSDAQAf>; Mon, 1 Apr 2002 11:00:35 -0500
Received: from dial-up-2.energonet.ru ([195.16.109.101]:10624 "EHLO
	dial-up-2.energonet.ru") by vger.kernel.org with ESMTP
	id <S311936AbSDAQA2>; Mon, 1 Apr 2002 11:00:28 -0500
Date: Mon, 25 Mar 2002 19:49:27 +0000
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Packet writing on CD-RW
Message-ID: <20020325194927.GA5211@bk.ru>
Mail-Followup-To: =?koi8-r?B?0JzQsNC60YHQuNC8INCb0LDQv9GI0LjQvQ==?= <ertzog@bk.ru>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux dial-up-2.energonet.ru 2.4.18 
From: Max <ertzog@bk.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Such programs, like Adaptec CD Creator, create a big map on a CD-RW,
because one place on CD-RW can be rewritten not more than about 15 times.
If this feature will be inserted in to kernel, the code, that handles that
map should be written. But isn't format of this map and algorithm of
working with it proprietary, closed standart? So, will developers have any
law problems with it?


Best regards.
