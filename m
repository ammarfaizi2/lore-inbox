Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbUASSLg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 13:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbUASSJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 13:09:11 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:7595 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S262353AbUASSIf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 13:08:35 -0500
Message-ID: <400C1D17.5050308@inp-net.eu.org>
Date: Mon, 19 Jan 2004 19:08:23 +0100
From: =?ISO-8859-15?Q?Rapha=EBl_RIGO?= <raphael.rigo@inp-net.eu.org>
User-Agent: Mozilla Thunderbird 0.5a (20040105)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-15?Q?Markus_H=E4stbacka?= <midian@ihme.org>,
       linux-kernel@vger.kernel.org
Subject: Re: ALSA vs. OSS
References: <1074532714.16759.4.camel@midux>
In-Reply-To: <1074532714.16759.4.camel@midux>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Hästbacka wrote:

> Hello list,
> I wonder what's the difference with ALSA and OSS. I have tried both,
> someone may say that ALSA is much better than OSS, but with my
> experience with ALSA I wouldn't say that, I would probably say it should
> be removed from the kernel totally.
> 
> So, what are the reasons for ALSA to become "default" in 2.6?
> I know it gives somekind of nice features, but ALSA didn't let me to
> open two sound sources (like XMMS and Quake3) at the same time, so I
> guess it is not really done yet, or is it?
> 
> Ignore this if you don't care.
> Thanks,
> Markus.
http://www.alsa-project.org/alsa-doc/doc-php/asoundrc.php3?company=Generic&card=Generic&chip=Generic&module=Generic#softmix
This will tell you how to enable software mixing with ALSA.
I'm not able to give a perfect answer for the reasons why ALSA has been chosen 
to replace OSS so i will let someone else answer :)

Raphaël.
