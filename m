Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264524AbTEJXIL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 19:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264525AbTEJXIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 19:08:11 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:16836 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S264524AbTEJXIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 19:08:10 -0400
Message-ID: <3EBD8941.7070403@blue-labs.org>
Date: Sat, 10 May 2003 19:20:33 -0400
From: David Ford <david+powerix@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030509
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Norbert Wolff <norbert_wolff@t-online.de>
CC: Andy Pfiffer <andyp@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: ALSA busted in 2.5.69
References: <fa.j6n4o02.sl813a@ifi.uio.no>	<fa.juutvqv.1inovpj@ifi.uio.no>	<3EBBF00D.8040108@hotmail.com>	<1052507530.15922.37.camel@andyp.pdx.osdl.net> <20030510080440.3446cc96.norbert_wolff@t-online.de>
In-Reply-To: <20030510080440.3446cc96.norbert_wolff@t-online.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shrug :)

I use devfs, all is magic.  All is [nearly always] correct.

David

Norbert Wolff wrote:

>On 09 May 2003 12:12:10 -0700
>Andy Pfiffer <andyp@osdl.org> wrote:
>
>  
>
>>I'm not using devfs, and I've had no luck getting ALSA to work on my
>>i810-audio system.  OSS works fine.
>>
>>Is there a step-by-step writeup available for morons like me that
>>haven't gotten ALSA working?
>>    
>>
>
>Hi Andy !
>
>The Problem seems to be that ALSA has moved their devices some weeks ago.
>In the alsa-driver-0.9.3a-Package (ftp://ftp.alsa-project.org) is a script
>called snddevices (attached) which creates the needed devices and links.
>
>Execute it as root and all should be fine ...
>
>Maybe this Script should be distributed with the Kernel too ?
>
>Regards,
>
>	Norbert
>
>
>  
>

