Return-Path: <linux-kernel-owner+willy=40w.ods.org-S287530AbUKASh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S287530AbUKASh6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 13:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270958AbUKARaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 12:30:09 -0500
Received: from mx2.redhat.com ([66.187.237.31]:21186 "EHLO mx2.redhat.com")
	by vger.kernel.org with ESMTP id S264330AbUKAQ5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 11:57:05 -0500
Message-ID: <41866AD6.3030907@bitplanet.net>
Date: Mon, 01 Nov 2004 11:56:54 -0500
From: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@bitplanet.net>
Organization: Red Hat, Inc
User-Agent: Mozilla Thunderbird 0.8 (X11/20041020)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Discuss issues related to the xorg tree <xorg@freedesktop.org>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: code bloat [was Re: Semaphore assembly-code bug]
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel>	<200410310000.38019.vda@port.imtp.ilyichevsk.odessa.ua>	<1099170891.1424.1.camel@krustophenia.net>	<200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua>	<20041030222720.GA22753@hockin.org>	<Pine.LNX.4.53.0410310744210.3581@yvahk01.tjqt.qr> <1099322253.3647.5.camel@krustophenia.net>
In-Reply-To: <1099322253.3647.5.camel@krustophenia.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Sun, 2004-10-31 at 07:49 +0100, Jan Engelhardt wrote:
> 
>>Z Smith wrote:
>>
>>>Or join me in my effort to limit bloat. Why use an X server
>>>that uses 15-30 megs of RAM when you can use FBUI which is 25 kilobytes
>>>of code with very minimal kmallocing?
>>
>>FBUI does not have 3d acceleration?
> 
> 
> Um I don't think chucking X is the answer.  The problem is that it's
> embarassingly slow compared to any modern GUI.  If the display were as
> snappy as WinXP I don't care if it's 200MB.  On my desktop I constantly
> see windows redrawing every freaking widget in situations where XP would
> just blit from an offscreen buffer or something.
> 
> Anyway please keep replies off LKML and on the Xorg list...

Actually, please keep replies off the Xorg list as well.

Thanks,
Kristian
