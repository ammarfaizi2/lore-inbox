Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbVAIT1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVAIT1r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 14:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbVAIT1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 14:27:39 -0500
Received: from smtp.uninet.ee ([194.204.0.4]:11780 "EHLO smtp.uninet.ee")
	by vger.kernel.org with ESMTP id S261740AbVAIT0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 14:26:36 -0500
Message-ID: <41E1854A.40201@tuleriit.ee>
Date: Sun, 09 Jan 2005 21:26:02 +0200
From: Indrek Kruusa <indrek.kruusa@tuleriit.ee>
Reply-To: indrek.kruusa@tuleriit.ee
User-Agent: Mozilla Thunderbird 0.8 (X11/20040923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roseline Bonchamp <roseline.bonchamp@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: remove Attach another file remove Attach another file remove
 Attach another file USB mass storage not always detecting my 1GB PQI intelligent
 stick
References: <884a349a050109082516b0740e@mail.gmail.com>	 <41E15F09.70502@tuleriit.ee> <884a349a0501091112300009ac@mail.gmail.com>
In-Reply-To: <884a349a0501091112300009ac@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Which distro/kernel do you have? Have you looked at your distro's 
bugzilla/buglist? Have you all latest update packages installed?


Roseline Bonchamp wrote:

>>Do you have several different USB devices connected in the same time? It
>>is possible that devices with different USB speed (high/full) cannot
>>work together. I am not the kernel developer but this is just my
>>experience with latest Linux distributions. The situation can be
>>different with current USB developments.
>>    
>>
>
>I tried to remove every other USB device. What is really strange is
>that it works when I've just booted Linux, but if I unplug/replug the
>device it seems to be "detected", but is not listed in
>/proc/bus/usb/devices
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>.
>
>  
>

