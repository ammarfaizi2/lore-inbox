Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290200AbSAQTkx>; Thu, 17 Jan 2002 14:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290201AbSAQTko>; Thu, 17 Jan 2002 14:40:44 -0500
Received: from hirogen.kabelfoon.nl ([62.45.45.69]:9997 "HELO
	hirogen.kabelfoon.nl") by vger.kernel.org with SMTP
	id <S290200AbSAQTka>; Thu, 17 Jan 2002 14:40:30 -0500
Message-ID: <3C47284A.9080607@kabelfoon.nl>
Date: Thu, 17 Jan 2002 20:38:50 +0100
From: Nick Martens <nickm@kabelfoon.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        linux-kernel@vger.kernel.org
Subject: Re: hangs using opengl
In-Reply-To: <20020117191450.932B64ADB4@drie.kotnet.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Dekervel wrote:

> op donderdag 17 januari 2002 18:09 , schreef Nick Martens  in 
> <3C4712DB.6090201@kabelfoon.nl> :
> 
> 
>>Hi,
>>I'm having some trouble with my box, at the time that i start an opengl
>>game in X sometimes the load of my machine gets really high (not in all
>>games Quake III runs just fine). when i try to move my mouse it won't
>>move, when i press CTRL-ALT-BACKSPACE nothing happens and I have to
>>reset my system. Is this kernel related or just an opengl problen ? if
>>it's kernel related I am running kernel 2.4.5 And my video-card is an
>>NVIDIA geforce 2 pro 450 from gainward. before this card i had a diamond
>>viper 770 ultra and the same problem occured. If this is not a kernel
>>issue: where can i go to solve this ????
>>
>>Greets Nick
>>
>>

Ok thanx all Another thing when it crashes the hd load seems extremely 
high. system config is Intel P3 1ghz, intel 815 chipset, kernel 2.4.5 
,xf86 4.1, kde 2.2

i also checked my logs:
/var/log/debug contains:

Jan 17 20:15:09 nick kernel: CPU: Before vendor init, caps: 0387f9ff 
00000000 00000000, vendor = 0
Jan 17 20:15:09 nick kernel: CPU: After vendor init, caps: 0387f9ff 
00000000 00000000 00000000
Jan 17 20:15:09 nick kernel: CPU:     After generic, caps: 0383f9ff 
00000000 00000000 00000000
Jan 17 20:15:09 nick kernel: CPU:             Common caps: 0383f9ff 
00000000 00000000 00000000
Jan 17 20:15:23 nick kernel: agpgart: unsupported bridge
Jan 17 20:15:23 nick kernel: agpgart: no supported devices found.


