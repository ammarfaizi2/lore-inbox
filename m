Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261555AbTCaJ44>; Mon, 31 Mar 2003 04:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261567AbTCaJ44>; Mon, 31 Mar 2003 04:56:56 -0500
Received: from icope-203-146-ban.icope.com ([203.196.146.203]:39164 "HELO
	icope.com") by vger.kernel.org with SMTP id <S261555AbTCaJ44>;
	Mon, 31 Mar 2003 04:56:56 -0500
Message-ID: <3E881337.50903@icope.com>
Date: Mon, 31 Mar 2003 15:36:47 +0530
From: _VJ <vjose@icope.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i686; en-US; 0.7) Gecko/20010316
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Probs in printk
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using printk for the device driver I'm writing.It doesn't give the 
output to my console and the only way I can get those is just using
cat  /proc/kmsg.But what I want is to get console prints while I'm 
running .Then I put the kernel image of the remote system where it used 
to give console output.Still I'm not getting any output to the screen.I 
tried to use console_print ....not giving any result to the console.So I 
would like to know what can I do about this

Thanx in advance.

Vj



