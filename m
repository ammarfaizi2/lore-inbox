Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265573AbUFDKeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265573AbUFDKeO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 06:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265718AbUFDKeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 06:34:13 -0400
Received: from tristate.vision.ee ([194.204.30.144]:58582 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S265573AbUFDKeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 06:34:12 -0400
Message-ID: <40C05028.9080302@vision.ee>
Date: Fri, 04 Jun 2004 13:34:16 +0300
From: =?ISO-8859-1?Q?Lenar_L=F5hmus?= <lenar@vision.ee>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040528)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dominik Karall <dominik.karall@gmx.net>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-rc2-mm2
References: <20040603015356.709813e9.akpm@osdl.org> <200406031703.38722.dominik.karall@gmx.net> <20040603161813.32ea0b84.akpm@osdl.org> <200406041017.44213.dominik.karall@gmx.net>
In-Reply-To: <200406041017.44213.dominik.karall@gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Karall wrote:

>>Can you get sysrq-T output?
>>    
>>
>
>As I didn't know whats that command, I googled for it and found that I must 
>hit Alt+SysRq+t and then debug information should be printed out, am I right? 
>But I tried that, and nothing happens. SYSCTL is enabled in the kernel 
>config.
>If you really need this output, I would be pleased if anybody can inform me 
>how I can get it. Thanks in advance!
>  
>
You must turn on SysRq support in kernel config (CONFIG_MAGIC_SYSRQ=y).

Lenar

