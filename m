Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316792AbSGHFcm>; Mon, 8 Jul 2002 01:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316794AbSGHFcl>; Mon, 8 Jul 2002 01:32:41 -0400
Received: from iproxy1.ericsson.dk ([213.159.160.68]:26793 "EHLO
	iproxy1.ericsson.dk") by vger.kernel.org with ESMTP
	id <S316792AbSGHFck>; Mon, 8 Jul 2002 01:32:40 -0400
Message-ID: <3D292464.3040400@fabbione.net>
Date: Mon, 08 Jul 2002 07:34:28 +0200
From: Fabio Massimo Di Nitto <fabbione@fabbione.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
X-Accept-Language: en
MIME-Version: 1.0
To: Riley Williams <rhw@InfraDead.Org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19pre10 DevFS + LVM OOPS
References: <Pine.LNX.4.21.0207072338030.9595-100000@Consulate.UFP.CX>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Riley Williams wrote:

>Hi Fabio.
>
>  
>
>>this happend creating a new a lv with the command lvcreate -L512M
>>-ntest system It did 3 times in a row then it worked again. What was
>>strange is that I was in one dir and unfortunalty I don't remember
>>which and it was crashing. I changed dir and then it was working. In
>>the first instance I didn't thought about taking notes but atleast I
>>have a full trace (the machine didn't hang or reboot... it is still
>>alive 100%).
>>    
>>
>
>This may be completely off-track but I've seen it cause wierd problems
>in the past, so worth checking - was the directory you were in when the
>machine crashed one that still existed as far as the file system was
>concerned?
>
Im fairly sure it is still there because I didn't made any
change in the filesystem (in terms of mv rm etc.) but
I will give it a try later since Im not close to the box
right now and a possible crash from remote is not really
a good idea ;)

Fabio


