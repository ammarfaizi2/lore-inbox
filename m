Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbUCIMHp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 07:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbUCIMHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 07:07:45 -0500
Received: from mailgate.uni-paderborn.de ([131.234.22.32]:37306 "EHLO
	mailgate.uni-paderborn.de") by vger.kernel.org with ESMTP
	id S261891AbUCIMHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 07:07:43 -0500
Message-ID: <404DB389.2030102@uni-paderborn.de>
Date: Tue, 09 Mar 2004 13:07:37 +0100
From: Bjoern Schmidt <lucky21@uni-paderborn.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Stefan Smietanowski <stesmi@stesmi.com>
CC: len.brown@intel.com, linux-kernel@vger.kernel.org
Subject: Re: fsb of older cpu
References: <A6974D8E5F98D511BB910002A50A6647615F47CB@hdsmsx402.hd.intel.com> <1078815523.2342.535.camel@dhcppc4> <404DA7A8.4090109@uni-paderborn.de> <404DABEC.4070605@stesmi.com>
In-Reply-To: <404DABEC.4070605@stesmi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-UNI-PB_FAK-EIM-MailScanner-Information: Please see http://imap.uni-paderborn.de for details
X-UNI-PB_FAK-EIM-MailScanner: Found to be clean
X-UNI-PB_FAK-EIM-MailScanner-SpamCheck: not spam, SpamAssassin (score=0,
	required 4)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Smietanowski schrieb:
> Hi Bjoern.
> 
>> In the System Programming Guide i can read that i can reprogram the
>> clock multiplier by setting RESET# to low and A20M#, IGNNE#, LINT[1]
>> and LINT[0] to 1111 for 1/2. Unfortunately i dont know how to
>> program this in assembler code, i can several programming
>> languages, but not yet asm :(
>> Can you recommend a good online book?
> 
> 
> Think for a moment what happens when you pull RESET# low :)
> 
> It... resets the chip thereby resetting the computer.

Ooops, you are right. I should better read the whole manual.
Sorry for asking stupid questions...


Greetings
Bjoern Schmidt


