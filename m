Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbTEaJXZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 05:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264255AbTEaJXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 05:23:24 -0400
Received: from h2.prohosting.com.ua ([217.106.231.81]:61912 "EHLO
	h2.prohosting.com.ua") by vger.kernel.org with ESMTP
	id S264256AbTEaJXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 05:23:21 -0400
From: Artemio <artemio@artemio.net>
To: Joel Jaeggli <joelja@darkwing.uoregon.edu>
Subject: Re: Xeon processor support
Date: Sat, 31 May 2003 12:31:16 +0300
User-Agent: KMail/1.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0305310204290.31933-100000@twin.uoregon.edu>
In-Reply-To: <Pine.LNX.4.44.0305310204290.31933-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200305311231.06582.artemio@artemio.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - h2.prohosting.com.ua
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - artemio.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> The new xeons work fine with 2.4.20. Issues with rtlinux should probably
> be directed to fsmlabs or their respective mailing lists...
Well, they seem to have no idea what's wrong. One guy at rtlinux mailing list 
had success building rtlinux-3.2-pre3 with 2.4.20 kernel on dual 2.4GHz Xeon 
machine. I have the same rtlinux-3.2-pre3 with 2.4.20 kernel on dual 2.4GHz 
Xeon machine, but rtlinux hangs it when I start it. That guy gave me his 
config but I didn't have any success anyway.

However, I have built the same 2.4.20/3.2-pre3 on PIII boxes and rtlinux runs 
perfectly.

> Outside that what issues are you seeing?
No issues. 
I just know that Intel Xeon and Intel Pentium 4 Xeon are different things, 
that's why I was asking - there is only a "Pentium 4" option in kernel 
config.


Thanks for reply.


Artemio.
