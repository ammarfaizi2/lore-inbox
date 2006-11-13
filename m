Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755176AbWKMQdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755176AbWKMQdh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755192AbWKMQdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:33:36 -0500
Received: from smtpout04-04.prod.mesa1.secureserver.net ([64.202.165.199]:19426
	"HELO smtpout04-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S1755176AbWKMQdg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:33:36 -0500
Message-ID: <45589E54.3000603@seclark.us>
Date: Mon, 13 Nov 2006 11:33:24 -0500
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Shaun Q <shaun@c-think.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Dual cores on Core2Duo not detected?
References: <Pine.BSO.4.64.0611122322060.30536@ref.nmedia.net>	 <4558773A.4040803@seclark.us>	 <Pine.BSO.4.64.0611130752270.21533@ref.nmedia.net>	 <9a8748490611130803o4dbd05a5w6d271136db5e4378@mail.gmail.com>	 <Pine.BSO.4.64.0611130804011.21533@ref.nmedia.net> <1163435248.15249.179.camel@laptopd505.fenrus.org>
In-Reply-To: <1163435248.15249.179.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>>Processor #0 6:15 APIC version 20
>>Setting APIC routing to physical flat
>>BIOS bug, no explicit IRQ entries, using default mptable. (tell your hw 
>>vendor)
>>    
>>
>
>hmmm smells like a disabled ACPI, since normally this info comes from
>ACPI nowadays, not the mptable
>
>
>
>
>if you want to mail me at work (you don't), use arjan (at) linux.intel.com
>Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org
>
>
>  
>
 From Shaun's previous E-Mail

Bootdata ok (command line is root=/dev/sda2 vga=0x31a acpi=off 

                                                                                                             
^^^^^^

-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



