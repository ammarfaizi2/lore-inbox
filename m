Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291266AbSBSLby>; Tue, 19 Feb 2002 06:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291267AbSBSLbo>; Tue, 19 Feb 2002 06:31:44 -0500
Received: from [195.63.194.11] ([195.63.194.11]:6159 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S291266AbSBSLba>;
	Tue, 19 Feb 2002 06:31:30 -0500
Message-ID: <3C723774.5070507@evision-ventures.com>
Date: Tue, 19 Feb 2002 12:31:00 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Jens Axboe <axboe@suse.de>, kernel list <linux-kernel@vger.kernel.org>,
        vojtech@ucw.cz
Subject: Re: /proc/driver support for ide
In-Reply-To: <20020214225006.GA161@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>Hi!
>
>Attached. This will allow me to do suspend to disk/ram, without eating
>data, once I add suspend/resume functions to ide-disk.c. As of now, it
>adds ide interface and ide disk to /proc/driver...
>
>Does it look like it could find its way to Linus?
>
The patch looks and works fine...

>



