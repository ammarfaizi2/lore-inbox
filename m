Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263633AbTEWWnZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 18:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263718AbTEWWnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 18:43:25 -0400
Received: from smtp2.poczta.onet.pl ([213.180.130.30]:31178 "EHLO
	smtp2.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S263633AbTEWWnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 18:43:24 -0400
Message-ID: <3ECFF85D.2090009@poczta.onet.pl>
Date: Sun, 25 May 2003 00:55:25 +0200
From: Gutko <gutko@poczta.onet.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Realtek 8139c - kernel 2.4.21-rc3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Just compiled this kernel with 8139too as module. I have adsl (pppoe) 
connection. Problem is, connection is lost after about 2-5 minutes after 
start.
I tested eth card with ftp://ftp.scyld.com/pub/diag/rtl8139-diag.c
and found something like this "configured with ABNORMAL settings".Or 
something like this. So I downloaded driver (v1.01)from www.realtek.com.tw,
replaced 8139too module and now all semms to be ok.
This diag tool says now : "configured with normal settings"

Gutko

