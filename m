Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268536AbUJDTaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268536AbUJDTaB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 15:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268505AbUJDT0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 15:26:33 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:56466 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S268520AbUJDTZ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 15:25:27 -0400
Message-ID: <4161A3DA.4000708@tmr.com>
Date: Mon, 04 Oct 2004 15:26:18 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jari Ruusu <jariruusu@users.sourceforge.net>
CC: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, Andi Kleen <ak@muc.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Florian Bohrer <florian.bohrer@t-online.de>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [PATCH] AES x86-64-asm impl.
References: <2KWl4-wq-25@gated-at.bofh.it> <416142DD.54E0E417@users.sourceforge.net>
In-Reply-To: <416142DD.54E0E417@users.sourceforge.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jari Ruusu wrote:
> Paolo Ciarrocchi wrote:
> 
>>On Mon, 04 Oct 2004 15:20:43 +0300, Jari Ruusu
>>I understand that, I still don't understand the reaseon.
>>But hey, feel free to ignore my question ;)
> 
> 
> You haven't looked at cryptoloop security, have you?
> 
> No sane person wants to be accociated with that kind of broken and
> backdoored scam. I certainly don't.
> 
Would you be happy if the code were wrapped as a general use package 
like blowfish, or have you decided that because one part of Linux 
doesn't meet your standards you don't want to allow any of your code to 
be used in it?


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
