Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262794AbVDHMZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbVDHMZc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 08:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262797AbVDHMZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 08:25:32 -0400
Received: from smtp.uninet.ee ([194.204.0.4]:7428 "EHLO smtp.uninet.ee")
	by vger.kernel.org with ESMTP id S262794AbVDHMZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 08:25:19 -0400
Message-ID: <4256782C.9090305@tuleriit.ee>
Date: Fri, 08 Apr 2005 15:25:16 +0300
From: Indrek Kruusa <indrek.kruusa@tuleriit.ee>
Reply-To: indrek.kruusa@tuleriit.ee
User-Agent: Mozilla Thunderbird 1.0 (X11/20050215)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm2
References: <20050408030835.4941cd98.akpm@osdl.org>
In-Reply-To: <20050408030835.4941cd98.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm2/
>  
>

Wow... it responds despite the load average of 83.63 :)

http://www.tuleriit.ee/progs/img/pic1.png
http://www.tuleriit.ee/progs/img/pic2.png
http://www.tuleriit.ee/progs/img/pic3.png


dmesg is not clean though:

TCP: time wait bucket table overflow
TCP: time wait bucket table overflow
TCP: time wait bucket table overflow
printk: 392 messages suppressed.
TCP: time wait bucket table overflow
printk: 290 messages suppressed.
TCP: time wait bucket table overflow
TCP: time wait bucket table overflow
TCP: time wait bucket table overflow
TCP: time wait bucket table overflow
TCP: time wait bucket table overflow
TCP: time wait bucket table overflow
TCP: time wait bucket table overflow
TCP: time wait bucket table overflow
TCP: time wait bucket table overflow
TCP: time wait bucket table overflow
printk: 295 messages suppressed.
TCP: time wait bucket table overflow


What I did:
- "bombing" httpd with JMeter (from another computer)
- copying files from USB memory device to harddisk
- copying file with scp


Indrek

