Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261464AbREQNef>; Thu, 17 May 2001 09:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261419AbREQNeZ>; Thu, 17 May 2001 09:34:25 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:32670 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S261422AbREQNeQ>; Thu, 17 May 2001 09:34:16 -0400
Message-ID: <3B03D350.6080006@AnteFacto.com>
Date: Thu, 17 May 2001 14:34:08 +0100
From: Padraig Brady <Padraig@AnteFacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-ac4 i686; en-US; rv:0.9) Gecko/20010505
X-Accept-Language: en
MIME-Version: 1.0
CC: mdaljeet@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: bindprocessor
In-Reply-To: <CA256A4F.003B5469.00@d73mta05.au.ibm.com> <3B03B5F5.F9EC01D3@uow.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Look @ the processor sets plugin @
http://resourcemanagement.unixsolutions.hp.com/WaRM/schedpolicy.html

Padraig.

Andrew Morton wrote:

>mdaljeet@in.ibm.com wrote:
>
>>How can I bind a user space process to a particular processor in  a SMP
>>environment?
>>
>
>You can't.
>
>Nick Pollitt had an implementation of prcctl() which does this
>http://www.uwsg.indiana.edu/hypermail/linux/kernel/0102.2/0214.html
>
>I have a /proc based one at
>http://www.uow.edu.au/~andrewm/linux/#cpus_allowed
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>


