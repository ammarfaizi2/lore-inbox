Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265936AbTBKL7f>; Tue, 11 Feb 2003 06:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267642AbTBKL7f>; Tue, 11 Feb 2003 06:59:35 -0500
Received: from [200.244.152.3] ([200.244.152.3]:40029 "HELO
	lablinux.ipiranga.com.br") by vger.kernel.org with SMTP
	id <S265936AbTBKL7e>; Tue, 11 Feb 2003 06:59:34 -0500
Message-ID: <3E48E759.6030508@ipiranga.com.br>
Date: Tue, 11 Feb 2003 09:06:50 -0300
From: =?ISO-8859-1?Q?Jos=E9_Francisco_Ribeiro_Neto?= 
	<xyko@ipiranga.com.br>
Reply-To: xyko_ig@ig.com.br
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: pt-br, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Software RAID problems
X-Priority: 1 (highest)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, let me apologize to not subscribe the list. I'm sending my 
question to that list because I did not found any other list that could 
solve my problem, but I can't keep attention to that kind of list 
because it's too technical.

I'm running a Brazilian distro called Conectiva CL8 with 2.4.18-3U8_4cl 
kernel version and raidtools-0.90-8cl.

My server is running on a very unstable site because of power supply 
problems and some times, when the server goes down because of power 
failure, when rebooting we face a lost of synchronization and the raid 
devices have to be resyncronized. I don't have any lost of data but the 
resync process brings a performance trouble.

There are anyone that could tell me if this is a known problem and if 
there is anything I can do to minimize my problems ? Unfortunately I 
can't solve the power supply problem :-(

Thanks in advance.

Xyko

