Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291610AbSBNMem>; Thu, 14 Feb 2002 07:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291608AbSBNMec>; Thu, 14 Feb 2002 07:34:32 -0500
Received: from [195.63.194.11] ([195.63.194.11]:58383 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S291619AbSBNMeZ>; Thu, 14 Feb 2002 07:34:25 -0500
Message-ID: <3C6BAEBC.3090002@evision-ventures.com>
Date: Thu, 14 Feb 2002 13:34:04 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18-pre9-mjc2
In-Reply-To: <E16bL89-0008Jl-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>>lm_sensors				(lm_sensors team)
>>>
>>Hum, the last time I merged that stuff into my own kernel, the
>>patch-generator that they ship did not include all of the drivers I
>>needed. Also, I'm missing i2c from your patch list. Is that intentional
>>or is the i2c patch not needed? Which lm_sensors version did you merge?
>>
>
>Be very careful merging lm_sensors. Incorrect use of it is a wonderful
>way to do things like totally destroy (back to factory) an ibm thinkpad.
>

Well that is only one single sensor driver... The rest work's rather nicely.

