Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265773AbTAOG7e>; Wed, 15 Jan 2003 01:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265777AbTAOG7e>; Wed, 15 Jan 2003 01:59:34 -0500
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:34223
	"HELO adsl-63-202-77-221.dsl.snfc21.pacbell.net") by vger.kernel.org
	with SMTP id <S265773AbTAOG7d>; Wed, 15 Jan 2003 01:59:33 -0500
Message-ID: <3E2508EB.70600@tupshin.com>
Date: Tue, 14 Jan 2003 23:08:27 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Unable to handle kernel NULL pointer kernel 2.4.21-pre3-ac4
References: <3E24DBAA.4060701@tupshin.com>
In-Reply-To: <3E24DBAA.4060701@tupshin.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI...the output I showed previously was on a tainted kernel(vmware 
modules), but after a fresh reboot and on the identical but untainted 
kernel, I got the same error while doing the same thing, namely 
converting a mysql myisam table to innodb. I did succesfully convert 
some tables without a problem, and the table that triggered the problem 
originally did succeed after rebooting.

-Tupshin



