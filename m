Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbVKFLzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbVKFLzG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 06:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbVKFLzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 06:55:06 -0500
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:19413
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S1750738AbVKFLzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 06:55:05 -0500
Message-ID: <436DEF22.4010903@ed-soft.at>
Date: Sun, 06 Nov 2005 12:55:14 +0100
From: Edgar Hucek <hostmaster@ed-soft.at>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jerome lacoste <jerome.lacoste@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: New Linux Development Model
References: <436C7E77.3080601@ed-soft.at>	 <20051105122958.7a2cd8c6.khali@linux-fr.org>	 <436CB162.5070100@ed-soft.at> <5a2cf1f60511060252t55e1a058o528700ea69826965@mail.gmail.com>
In-Reply-To: <5a2cf1f60511060252t55e1a058o528700ea69826965@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jerome lacoste wrote:

> On 11/5/05, Edgar Hucek <hostmaster@ed-soft.at> wrote:
>  
>
>> Hi.
>>
>> Sorry for not posting my Name.
>>
>> Maybe you don't understand what i wanted to say or it's my bad english.
>> The ipw2200 driver was only an example. I had also problems with, 
>> vmware,
>> unionfs...
>> What i mean ist, that kernel developers make incompatible changes to the
>> header
>> files, change structures, interfaces and so on. Which makes the kernel
>> releases
>> incompatible.
>>   
>
>
> I will ask you just one question: as a user, why did you want to
> upgrade your kernel?
>  
>
Depends on the user and what he wants to do. There are several
reasons why a user wanna upgrade to new kernel. Maybe new supported
hardware and so on. It's frustrating for the user, have on the one side the
new hardware supported but on the other side, mybe broken support for
the existing hardware.

> On a server you want stability. So you don't upgrade.

Sure, but what about securrity updates. When a new kernel release
comes out the updates are stopped for older releases. And why should
dirstribution makers always backport new security fixes ?

> On a desktop, there are probably a bunch of out of kernel modules that 
> will need
> upgrading with each new kernel modules. Just on the laptop I am using
> right now, I will have to upgrade the vmware bridge, nvidia driver,
> madwifi wireless driver, etc. And that's normal. The new development
> model didn't change that.
>  
>
 From my point of view, it makes a difference if i have to recompile
a module or realy upgrade it.

> I avoid touching my kernel on boxes I do real work with. I do build a
> new kernel for test purposes and to give feedback if there's an issue.
> But most of the time I skip 2-3 versions before finding a very
> compelling reason to upgrade. And I stick with my distribution kernel
> as much as I can.
>
>  
>
So you wanna say a new "stable" kernel isn't a realy a stable one
and i can't relay that it behaves like the older one ? If it's so, then
something is completely wrong in kernel development.

> As for kernel/drivers developers, it's another story.
>
> If it ain't broken, don't fix it.
>
> Jerome
>
>  
>

cu

ED.

