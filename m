Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318259AbSHUMN4>; Wed, 21 Aug 2002 08:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318263AbSHUMNz>; Wed, 21 Aug 2002 08:13:55 -0400
Received: from [204.60.9.96] ([204.60.9.96]:18841 "HELO myeastern.com")
	by vger.kernel.org with SMTP id <S318259AbSHUMNz>;
	Wed, 21 Aug 2002 08:13:55 -0400
Message-ID: <3D638501.1020108@myeastern.com>
Date: Wed, 21 Aug 2002 08:18:09 -0400
From: Rohan Deshpande <rohan@myeastern.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020818
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: preempt count -- logging off?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The subject basically says it all .. I want to turn off kernel logging 
of preempt, but I see no option in kernel config.  It is all over my 
dmesg and various logs, and I fear it is slowing my system's 
responsiveness. Any ideas? ex.:

mozilla[11409] exited with preempt_count 2
mozilla-bin[18289] exited with preempt_count 3
mozilla-bin[1531] exited with preempt_count 1
netstat[28025] exited with preempt_count 3
xmms[19505] exited with preempt_count 1

Thanks a lot!

-R

