Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289671AbSA2MR7>; Tue, 29 Jan 2002 07:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289628AbSA2MQy>; Tue, 29 Jan 2002 07:16:54 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:28849 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S289627AbSA2MP6>; Tue, 29 Jan 2002 07:15:58 -0500
Message-ID: <3C5691F0.30105@wanadoo.fr>
Date: Tue, 29 Jan 2002 13:13:36 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020126
X-Accept-Language: en-us
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext2 fs corruption and usb devices
In-Reply-To: <Pine.LNX.4.44.0201290831360.20095-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> But i still think proprietory modules showing up in problem traces is 
> usually enough to warrant the trace as useless. The fact that it works now 
> and not then could be anybody's guess.

The kernel module is actually open-source and could even be merged in 
the kernel tree. If the modem was smart it would run its own firmware 
without relying on the client's machine to do it.

Q1: Are the ST USB drivers for Linux completely Open Source ?

A1: Alcatel supports the Open Source Movement, but feels it has to 
protect it's Intellectual property. Therefore, The drivers are only 
partially Open Source.
There is a open source kernel-module (GPL) and a closed source 
management application. The management application is distributed as a 
binary and contains the firmware.


Pierre
-- 
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

