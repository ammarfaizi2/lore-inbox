Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbVDKCgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVDKCgV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 22:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVDKCgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 22:36:21 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:65263 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261665AbVDKCgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 22:36:16 -0400
Date: Sun, 10 Apr 2005 20:34:13 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: very high temperatures in Asus notebook
In-reply-to: <3RUFa-6zx-13@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4259E225.4090006@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
X-Accept-Language: en-us, en
References: <3RUFa-6zx-13@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zé wrote:
> I would like to understand why using linux, my notebook gets much higher 
> temperatures than using windows, in linux i get about 67º celcius grades.

> Im pasting here the sensors output:
> ]# sensors
> it87-isa-0800
> Adapter: ISA adapter
> VCore 1:   +0.00 V  (min =  +1.42 V, max =  +1.57 V)   ALARM
> VCore 2:   +0.00 V  (min =  +2.40 V, max =  +2.61 V)   ALARM
> +3.3V:     +0.00 V  (min =  +3.14 V, max =  +3.46 V)   ALARM
> +5V:       +0.00 V  (min =  +4.76 V, max =  +5.24 V)   ALARM
> +12V:      +0.00 V  (min = +11.39 V, max = +12.61 V)   ALARM
> -12V:     -27.36 V  (min = -12.63 V, max = -11.41 V)   ALARM
> -5V:      -13.64 V  (min =  -5.26 V, max =  -4.77 V)   ALARM
> Stdby:     +0.00 V  (min =  +4.76 V, max =  +5.24 V)   ALARM
> VBat:      +3.28 V
> fan1:     135000 RPM  (min =    0 RPM, div = 2)
> fan2:        0 RPM  (min = 2657 RPM, div = 2)
> fan3:        0 RPM  (min = 2657 RPM, div = 2)
> M/B Temp:    +67°C  (low  =   +15°C, high =   +40°C)   sensor = diode
> CPU Temp:    +67°C  (low  =   +15°C, high =   +45°C)   sensor = diode
> Temp3:       +67°C  (low  =   +15°C, high =   +45°C)   sensor = diode

I'm doubting that those temperatures are accurate, considering how 
screwed up all the other parameter values are..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

