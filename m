Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965121AbWIRMaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121AbWIRMaO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 08:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965123AbWIRMaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 08:30:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:998 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965121AbWIRMaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 08:30:11 -0400
Message-ID: <450E914C.90203@redhat.com>
Date: Mon, 18 Sep 2006 08:30:04 -0400
From: Rik van Riel <riel@redhat.com>
Organization: Red Hat, Inc
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: yogeshwar sonawane <yogyas@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How much kernel memory is in 64-bit OS ?
References: <b681c62b0609160434g6ccbbaa0vd0cd68958696726e@mail.gmail.com> <450DE3DE.50301@redhat.com> <Pine.LNX.4.61.0609181033350.27566@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0609181033350.27566@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>> It depends on the architecture.
>>
>> However, all 64 bit architectures have one thing in common.
>> There is so much address space available for both kernel and
>> userspace that we won't have to worry about a shortage for a
>> very long time.
>>
>> Sure, people said that too when going from 16 bits to 32 bits,
>> but that was only a factor 2^16 difference.  This time it's the
>> square of the previous difference.
> 
> Not quite the square :)

2^32 is the square of 2^16 :)

-- 
What is important?  What you want to be true, or what is true?
