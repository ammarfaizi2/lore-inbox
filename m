Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262076AbVDLJeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbVDLJeY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 05:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbVDLJeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 05:34:23 -0400
Received: from [193.112.238.6] ([193.112.238.6]:3766 "EHLO caveman.xisl.com")
	by vger.kernel.org with ESMTP id S262076AbVDLJeT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 05:34:19 -0400
Subject: Exploit in 2.6 kernels
From: John M Collins <jmc@xisl.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Xi Software Ltd
Date: Tue, 12 Apr 2005 10:34:15 +0100
Message-Id: <1113298455.16274.72.camel@caveman.xisl.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC any reply to jmc AT xisl.com as I'm not subscribed - thanks

We had 5 machines broken into last night all but one with kernel 2.6.8
and found a binary "krad-no-longer-private.c" had  been downloaded

It contains the string:
 
k-rad.c - linux 2.6.* CPL 0 kernel exploit 
Discovered Jan 2005 by sd <sd@fucksheep.org>

If you want to look at it, I've copied it (with mode set to 444 of
course) to www.xisl.com/hack

Hope that is helpful

-- 
John Collins Xi Software Ltd www.xisl.com Tel: +44 (0)1707 886110
(Direct) +44 (0)7799 113162 (Mobile)

