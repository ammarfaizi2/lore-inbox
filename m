Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270854AbTGPOnT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 10:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270891AbTGPOnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 10:43:19 -0400
Received: from [192.188.53.79] ([192.188.53.79]:32260 "EHLO mailbk.usfq.edu.ec")
	by vger.kernel.org with ESMTP id S270854AbTGPOnR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 10:43:17 -0400
Message-ID: <3F156611.8000302@mail.usfq.edu.ec>
Date: Wed, 16 Jul 2003 09:49:53 -0500
From: Fernando Sanchez <fsanchez@mail.usfq.edu.ec>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: Eugene Teo <eugene.teo@eugeneteo.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: modules problems with 2.6.0
References: <3F147B8F.5000103@mail.usfq.edu.ec> <20030716084314.GB31074@lisa> <20030716091038.GA2355@eugeneteo.net>
In-Reply-To: <20030716091038.GA2355@eugeneteo.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eugene Teo wrote:
> <quote sender="Marc Schiffbauer">
> 
>>* Fernando Sanchez schrieb am 16.07.03 um 00:09 Uhr:
>>
>>>Hi,
>>>
>>>I've been trying to get 2.6.0 to work, I've enabled modules support, but 
>>>I get this error on my logs:
>>>
>>>Jul 15 15:38:36 Darakemba kernel: No module symbols loaded - kernel 
>>>modules not enabled.
>>>
>>>Is there any thing like a new modutils that should be used with 2.6.x 
>>>family?
>>>
>>>The kernel does boot, but not having any modules I can't do much, and 
>>>also, I never get to really see the messages on screen, on logs I have 
>>>this line:
>>>
>>>Jul 15 15:38:36 Darakemba kernel: Video mode to be used for restore is ffff
>>>
>>>What does it mean?
>>>
>>>I disabled all the framebuffer things so I can just use vga, on lilo, 
>>>vga mode is set to normal, but still can't see anything.
>>
>>Fernando,
>>
>>
>>read http://www.codemonkey.org.uk/post-halloween-2.5.txt
>>(but hsving DNS problems from germany right now)
> 
> 
> If you are using debian, apt-get install module-init-tools.
Thanks, it seems to work better than the source I get, well, I actually 
screwed up something with the sources, and dpkg was able to fix it for me :)
> 


-- 


Fernando Sanchez
Dpto. Sistemas USFQ



