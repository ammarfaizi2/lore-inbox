Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263049AbRE1L2t>; Mon, 28 May 2001 07:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263034AbRE1L2j>; Mon, 28 May 2001 07:28:39 -0400
Received: from bosch82.ncsa.es ([194.224.235.82]:24331 "EHLO www.bosch.es")
	by vger.kernel.org with ESMTP id <S263032AbRE1L2h>;
	Mon, 28 May 2001 07:28:37 -0400
Message-ID: <3B123648.9080707@juridicas.com>
Date: Mon, 28 May 2001 13:28:08 +0200
From: Jorge =?UTF-8?B?TmVyw61u?= <jnerin@juridicas.com>
Reply-To: comandante@zaralinux.com
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.14 i686; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: es-es, en
MIME-Version: 1.0
To: Jaswinder Singh <jaswinder.singh@3disystems.com>
CC: Randy <randys@evcom.net>, linux-kernel@vger.kernel.org
Subject: Re: CPU Dedicated Interrupts
In-Reply-To: <3B0FBF11.21EB8F87@evcom.net> <00be01c0e71e$49840d80$52a6b3d0@Toshiba>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaswinder Singh wrote:

>> What is the easiest way to tell a CPU to ignore certain interrupts from
>> module?
>> Is there an IRQ mask for each processor? Is that symbol exported?
>> 
> 
> I also what to know this :)
> 
> Please help us .
> 
> Thank you.
> 
> Jaswinder.
> --
> These are my opinions not 3Di.
> 
It's not a symbol, look for info about /proc/[irq-number]/smp_affinity 
in /Documentation.

-- 
Jorge Nerin
<comandante@zaralinux.com>

