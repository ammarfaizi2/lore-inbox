Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261478AbSJYQeQ>; Fri, 25 Oct 2002 12:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261483AbSJYQeQ>; Fri, 25 Oct 2002 12:34:16 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:55799 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP
	id <S261478AbSJYQeO>; Fri, 25 Oct 2002 12:34:14 -0400
Message-ID: <3DB99DD8.9020500@verizon.net>
Date: Fri, 25 Oct 2002 12:39:04 -0700
From: Stephen Wille Padnos <stephen.willepadnos@verizon.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Josh Myer <jbm@joshisanerd.com>
CC: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KB Gear JamStudio USB Tablet
References: <Pine.LNX.4.44.0210250200290.25878-200000@blessed>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at out001.verizon.net from [64.223.81.164] at Fri, 25 Oct 2002 11:40:24 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It might not hurt to change the configure help text so that the correct 
module name is displayed :)

-  The module will be called wacom.o.  If you want to compile it as a
+  The module will be called kbpad.o.  If you want to compile it as a




