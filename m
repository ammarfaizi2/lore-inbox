Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261872AbSK0KDU>; Wed, 27 Nov 2002 05:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261874AbSK0KDT>; Wed, 27 Nov 2002 05:03:19 -0500
Received: from mail-in1.inet.tele.dk ([194.182.148.158]:29765 "HELO
	mail-in1.inet.tele.dk") by vger.kernel.org with SMTP
	id <S261872AbSK0KDS>; Wed, 27 Nov 2002 05:03:18 -0500
Message-ID: <3DE49A66.4020208@sentinel.dk>
Date: Wed, 27 Nov 2002 11:11:50 +0100
From: Frederik Dannemare <tux@sentinel.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; da-DK; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Limiting max cpu usage per user (old Conectiva patch)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

do we have an effective way to limit max cpu usage per user? I haven't been 
able to find much useful info except for an old thread on lkml, where Rik 
van Riel mentions[1] a 2.2 kernel patch by Conectiva.

Anybody knows if this patch (or similar functionality) been ported to 2.4 
(or 2.5)?

[1]http://www.uwsg.iu.edu/hypermail/linux/kernel/0108.2/0362.html

--
Frederik


