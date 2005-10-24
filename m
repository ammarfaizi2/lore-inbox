Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbVJXXMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbVJXXMj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 19:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbVJXXMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 19:12:39 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:11706 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751377AbVJXXMi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 19:12:38 -0400
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Tue, 25 Oct 2005 01:12:37 +0200
In-reply-to: <435D8419.8050602@lindevel.ru>
To: "Nikolay N. Ivanov" <group@lindevel.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.13.4: don't reboot
Message-Id: <20051024231235.3C0F81CB1E6@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikolay N. Ivanov wrote:
>>>HP Compaq nx6110 don't reboot with kernel 2.6.13.4.
>>>    
>>>
>>The last OK was?
>>  
>>
>>>Poweroff and acpi functions works normally. Is it kernel bug?
>>>    
>>>
>>May be.
>>  
>>
>There are also such problem in kernel 2.6.11.6 appeared (other 
>distributive) but 2.6.10 works normally with the same config parameters. 
>I believe that it's kernel bug.
OK, I sent e-mail that wasn't delivered :(. Maybe the unicode `pishyot' was the
problem.

So, could you accurate the version where that occurs first time as much as
possible. I.e. the best is to tell us it is between 2.6.11.5 and 6 or sth.

Then make a diff -u between dmesg -s 1000000 of the 2 versions and attach used
.config.

thanks,
--
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
