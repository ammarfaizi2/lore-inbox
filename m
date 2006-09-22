Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWIVTSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWIVTSG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 15:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWIVTSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 15:18:05 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:11207 "EHLO
	fmmailgate02.web.de") by vger.kernel.org with ESMTP id S932174AbWIVTLt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 15:11:49 -0400
Message-ID: <0e2001c6de7a$fe756280$962e8d52@aldipc>
From: "roland" <devzero@web.de>
To: <linux-kernel@vger.kernel.org>
Subject: I/O statistics per process
Date: Fri, 22 Sep 2006 21:12:05 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

it`s great that linux now has i/o re-nice with cfq now, but how can the 
admin determine HOW MUCH i/o a process is actually generating ?

have seen this on windows (process explorer from sysinternals) and on 
solaris: (psio http://users.tpg.com.au/bdgcvb/psio.html  and pio
http://www.stormloader.com/yonghuang/freeware/pio.html),  but what`s the 
Linux (commandline) equivalent ?

is there a modified top/ps with i/o column, or is there yet missing 
something at the kernel level for getting that counters from ?


regards
Roland K.
systems engineer. 

