Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265646AbRFWF6l>; Sat, 23 Jun 2001 01:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265647AbRFWF6b>; Sat, 23 Jun 2001 01:58:31 -0400
Received: from james.kalifornia.com ([208.179.59.2]:35936 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S265646AbRFWF6L>; Sat, 23 Jun 2001 01:58:11 -0400
Message-ID: <3B342FEC.5060207@blue-labs.org>
Date: Fri, 22 Jun 2001 22:58:04 -0700
From: David Ford <david@blue-labs.org>
Organization: Blue Labs
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.1+) Gecko/20010622
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: linux-kernel@vger.kernel.org
Subject: [working] Re: Cleanup kbuild for aic7xxx (attn: Alan & Doug)
In-Reply-To: <200106230511.f5N5BMU84559@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin T. Gibbs wrote:

>>Here is the output of a plain jane 2.4.5 compile with the 'new' adaptec 
>>compiled in:
>>
>
>Yup.  Interrupts are not working for the chip.  See my other reply
>for a possible work around.
>
>--
>Justin
>

Wow.

Ok, changing it to UNI and enabling the APIC stuff has made it boot just 
dandy.  I really appreciate your advice.  Thank you.

Now, if Alan and Doug are interested, here is some information of the 
system.

http://stuph.org/440GX-boot.dmesg
http://stuph.org/440GX-lspci
http://stuph.org/440GX-dump_pirq

David


