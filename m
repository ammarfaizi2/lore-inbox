Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWEVKMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWEVKMm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 06:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWEVKMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 06:12:42 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:43650 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750708AbWEVKMl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 06:12:41 -0400
Message-ID: <44718DE0.7030508@aitel.hist.no>
Date: Mon, 22 May 2006 12:09:36 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?UTF-8?B?IkTDtmhyLCBNYXJrdXMgSUNDLUgi?= 
	<Markus.Doehr@siegenia-aubi.com>
CC: "'Peter Gordon'" <codergeek42@gmail.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: replacing X Window System !
References: <FC7F4950D2B3B845901C3CE3A1CA6766333F93@mxnd200-9.si-aubi.siegenia-aubi.com>
In-Reply-To: <FC7F4950D2B3B845901C3CE3A1CA6766333F93@mxnd200-9.si-aubi.siegenia-aubi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Döhr, Markus ICC-H wrote:

>>>Although one has to admit that working with remote X 
>>>      
>>>
>>terminals over a
>>    
>>
>>>SSH/WAN/VPN-connection is far from usefull, [...]
>>>      
>>>
>>You can tunnel just about anything X11 over SSH/VPN/etc.; even things
>>like a whole desktop GUI; not just plain X terminals.
>>    
>>
>
>Did you actually do that? Starting Firefox over a 6 Mbit VPN takes about 3
>minutes on a FAST machine. That´s not acceptable - our users want (almost)
>immediate response to an application, to clicking and waiting 10 seconds
>until the app is doing something.
>  
>
It is not that bad.  I tried starting firefox on a machine 20km away,
using a 5Mbps ADSL link from the "wrong" end.  (I ssh'ed into
my home pc from work.)
Firefox started in 55s, not 3min. Still bad, but that is a firefox
problem, not a generic X-tunneling problem.  I can start the
lyx word processor in 3s over the same link, and have decent
performance while using it too.

Helge Hafting
