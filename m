Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265398AbUAJT7K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 14:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265373AbUAJT5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 14:57:30 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:3005 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S265365AbUAJT4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 14:56:18 -0500
Message-ID: <400058DF.7010307@bluewin.ch>
Date: Sat, 10 Jan 2004 20:56:15 +0100
From: Patrick Steiner <patricksteiner@bluewin.ch>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: de-ch, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problems with Samba (setsockopt SO_BSDCOMPAT)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What can it mean when the kernel 2.6.1 every time when i boot this 
messages prints:

Jan 10 20:42:48 mybag kernel: process `snmptrapd' is using obsolete 
setsockopt SO_BSDCOMPAT
Jan 10 20:42:48 mybag kernel: process `snmpd' is using obsolete 
setsockopt SO_BSDCOMPAT


and another courios thing is this message when i start a program (like 
/usr/bin/top):

Unknow HZ Value (90) Assume 100


