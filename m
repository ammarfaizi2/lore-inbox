Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265624AbTGRNa6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 09:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265772AbTGRNa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 09:30:58 -0400
Received: from [193.137.96.140] ([193.137.96.140]:28397 "EHLO dwarf.utad.pt")
	by vger.kernel.org with ESMTP id S265624AbTGRNa5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 09:30:57 -0400
X-Spam-Filter: check_local@dwarf.utad.pt by digitalanswers.org
X-Spam-Header: 550.Reject.Received:count_Received
Message-ID: <3F17EBE2.8020304@alvie.com>
Date: Fri, 18 Jul 2003 13:45:22 +0100
From: Alvaro Lopes <alvieboy@alvie.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030527 Debian/1.3.1-2
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Subject: Re: 2.6.0-test1-ac2 issues / Toshiba Laptop keyboard
References: <20030717141847.GF7864@charite.de> <m38yqxf2ab.fsf@lugabout.jhcloos.org> <20030717201039.GC25759@charite.de> <1058474421.1724.3.camel@LNX.iNES.RO> <20030718063608.GE6429@charite.de>
In-Reply-To: <20030718063608.GE6429@charite.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Hildebrandt wrote:

>* Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>:
>
>  
>
>>I noticed the same oddity on my Toshiba Sattelite Pro 6100 and choosed
>>to silece it with the following (trivial) patch. No side effects so
>>far..
>>    
>>
>
>That removes the symptom, but not the cause.
>
>  
>
I believe this is caused by hardware itself. The key bounces and the 
keyboard hw generates spurious keypressings.

Álvaro

