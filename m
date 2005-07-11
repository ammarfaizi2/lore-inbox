Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262146AbVGKRf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262146AbVGKRf4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 13:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262107AbVGKRdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 13:33:37 -0400
Received: from sicnat2.emn.fr ([193.54.76.193]:32980 "EHLO ron.emn.fr")
	by vger.kernel.org with ESMTP id S261941AbVGKRci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 13:32:38 -0400
Message-ID: <42D2AD08.3050500@eleve.emn.fr>
Date: Mon, 11 Jul 2005 19:31:52 +0200
From: Paul RIVIER <paul.rivier@eleve.emn.fr>
Reply-To: paul.rivier@eleve.emn.fr
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-thinkpad@linux-thinkpad.org
CC: Paul Sladen <thinkpad@paul.sladen.org>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>,
       Eric Piel <Eric.Piel@tremplin-utc.net>, borislav@users.sourceforge.net,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [ltp] IBM HDAPS Someone interested? (Userspace accelerometer
 viewer)
References: <Pine.LNX.4.21.0507111011170.25721-100000@starsky.19inch.net> <1121092015.7407.68.camel@localhost.localdomain>
In-Reply-To: <1121092015.7407.68.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I recieved my laptop last week, I had windows preinstalled on and 
before reinstalling a proper free system, I wanted to have a look to 
that feature, so I lauched the ibm HDAPS monitor. But to my mind 
precision is not really good, and when you roll your laptop twice or 
more the monitor forget its initial position and movements are only 
relative (may be a software issue, I don't know). But i love your idea ;)

Paul

Alan Cox wrote:

>On Llu, 2005-07-11 at 10:42, Paul Sladen wrote:
>  
>
>>  theta = (N - 512) * 0.5
>>
>>provides a surprisingly good approximation for pitch/roll values in degrees
>>in the range (-90..+90) so I think the sensor can do ~= +/-2.5G .
>>
>>  http://www.paul.sladen.org/thinkpad-r31/aps/accelerometer-screenshot.png (9kB)
>>    
>>
>
>Is the quality good enough to use it DEC itsy style as an input device
>for games like Marble madness ?
>
>  
>
