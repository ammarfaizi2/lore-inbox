Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264465AbUEMToN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264465AbUEMToN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 15:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264709AbUEMTmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:42:24 -0400
Received: from zamok.crans.org ([138.231.136.6]:48040 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S264465AbUEMTlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:41:00 -0400
Message-ID: <40A3CF33.9030504@minas-morgul.org>
Date: Thu, 13 May 2004 21:40:35 +0200
From: Mathieu Segaud <matt@minas-morgul.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040502
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: gene.heskett@verizon.net,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-mm2 foibles
References: <200405131442.27573.gene.heskett@verizon.net> <1084475560.1793.0.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1084475560.1793.0.camel@teapot.felipe-alfaro.com>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana wrote:

>On Thu, 2004-05-13 at 20:42, Gene Heskett wrote:
>  
>
>>Greetings;
>>
>>I just booted to a 2.6.6-mm2 kernel, and discoverd I had no sound.  So 
>>I logged back out of x, and found I had no keyboard!  ssh'd in from 
>>the firewall and rebooted it.
>>
>>Both sound, and the backswitch from x were working perfectly up to and 
>>including 2.6.6.
>>    
>>
>
>I'm also having problems with 2.6.6-mm2 and losing my keyboard. After
>logging into X, after a while, the keyboard stops responding. However,
>my USB mouse still works.
>  
>
I had this problem too, and I tried reverting bk-input.patch; it works, 
but it won't help. This is a huge Bitkeeper patch...

-- 
Mathieu Segaud
