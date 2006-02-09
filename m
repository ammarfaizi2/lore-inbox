Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbWBIRBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWBIRBu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 12:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWBIRBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 12:01:50 -0500
Received: from linux.dunaweb.hu ([62.77.196.1]:61669 "EHLO linux.dunaweb.hu")
	by vger.kernel.org with ESMTP id S932487AbWBIRBt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 12:01:49 -0500
Message-ID: <43EB7E28.2030208@freemail.hu>
Date: Thu, 09 Feb 2006 18:38:48 +0100
From: Zoltan Boszormenyi <zboszor@freemail.hu>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: hu-hu, hu, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>DervishD <lkml@dervishd.net> wrote:
>
>>     Could you please clarify which things are broken by Matthias
>> patch? This way he (or other developer) can prepare a better patch
>> and maintain it. BTW, I patched my cdrecord with Matthias patch and
>> nothing seems to be broken :? Maybe am I missing something?
>
>It is completely broken and thus makes no sense at all.
>
>As I did write it looks lie a dentist drills a hole into an aking tooth
>and then claims to be complete with the whole treatment.
>
>Jörg
>  
>

It is a nicely written metaphor but hardly qualifies as  a technical 
argument.
Sorry, -1 point for you for being such a bully. You obviously didn't look at
Matthias' patch, you even expressed unwillingness to look at it.
I would be _very_ surprised if at the end you actually read or
(oh, the horror!) test it.

I have followed every such threads that ended in a flamefest.

Folks, please, cdrecord is GPL, at least up to 2.01.01a06.
Take this version and ask for help from the wizards at forum.rpc1.org
in forking. They drink, eat and breath CD-R[W] and DVD+-R[W] firmwares,
they surely know vendor commands, they must be able to understand
Jörg's software and maybe improve upon it. They can validate the
ossdvd patch, and fix it if it's buggy. For those who don't know,
there even exists a firmware updater for Pioneer DVD+-RW
drives that work on Linux with /dev entries, on a live system,
without the need for a reboot... http://lasvegas.rpc1.org/
Look, Jörg, they don't need HOST/TARGET/LUN triplets for this task!

Best regards,
Zoltán Böszörményi

