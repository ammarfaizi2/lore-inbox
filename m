Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265541AbUFOO5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265541AbUFOO5Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 10:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265661AbUFOO5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 10:57:24 -0400
Received: from tristate.vision.ee ([194.204.30.144]:13754 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S265541AbUFOO5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 10:57:21 -0400
Message-ID: <40CF0E65.30705@vision.ee>
Date: Tue, 15 Jun 2004 17:57:41 +0300
From: =?ISO-8859-1?Q?Lenar_L=F5hmus?= <lenar@vision.ee>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Karel_Kulhav=FD?= <clock@twibright.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: hp omnibook xe4500 and keyboard
References: <20040615142626.A6275@beton.cybernet.src>
In-Reply-To: <20040615142626.A6275@beton.cybernet.src>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I seem to remember that xe4500 has BIOS option 'USB legacy mode' or 
something
similar which you should disable. Then it should work fine.

Lenar

Karel Kulhavý wrote:

>Hello
>
>I am having hp omnibook xe4500 which has an integrated keyboard and I am
>having also external USB mouse. There is an internal mouse inside.
>
>What should I tick up in 2.4.25 in "Input core" and "USB HID" so that
>1) keyboard works upon bootup
>2) USB mouse works
>
>I have determined these things are dependent on almost everything in the
>kernel configuration, for example CONFIG_AGP and CONFIG_DRM.
>
>Cl<
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

