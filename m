Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269718AbRH0XNY>; Mon, 27 Aug 2001 19:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269726AbRH0XNO>; Mon, 27 Aug 2001 19:13:14 -0400
Received: from ultra.sonic.net ([208.201.224.22]:23316 "EHLO ultra.sonic.net")
	by vger.kernel.org with ESMTP id <S269718AbRH0XNC>;
	Mon, 27 Aug 2001 19:13:02 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Mon, 27 Aug 2001 16:13:17 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Random syslog messages
Message-ID: <20010827161317.B19067@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Everyone once in a while, I see the following syslog message:

Aug 27 16:04:21 thune 

It is apparently coming in at the kernel.crit level.

Any ideas on what might be causing this?  (I suspose I could be using a
broken sysklogd or something, but I wondering if it really was coming from
the kernel.)

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
