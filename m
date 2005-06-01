Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVFALwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVFALwb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 07:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVFALwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 07:52:31 -0400
Received: from smtp1.brturbo.com.br ([200.199.201.163]:3270 "EHLO
	smtp1.brturbo.com.br") by vger.kernel.org with ESMTP
	id S261339AbVFALwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 07:52:10 -0400
Message-ID: <429DA166.8040708@brturbo.com.br>
Date: Wed, 01 Jun 2005 08:52:06 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: mkrufky@m1k.net, video4linux-list@redhat.com, linux-kernel@vger.kernel.org,
       Manuel Capinha <mcapinha@gmail.com>
Subject: Re: [PATCH] Video for Linux Docummentation
References: <429D2A7C.1080002@gmail.com>	<429D4459.2060206@m1k.net> <20050531221830.14e7463e.akpm@osdl.org>
In-Reply-To: <20050531221830.14e7463e.akpm@osdl.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Michael Krufky <mkrufky@m1k.net> wrote:
>  
>
>> My fix-for-cx88-cardsc-for-dvico-fusionhdtv-3-gold-q.patch in -mm 
>> conflicts with the Video for Linux Documentation patch.
>>    
>>
>
>I got it all merged up OK.
>
>  
>
>> I think you 
>> should just drop my patch, since it's in v4l cvs as card=28 (instead of 
>> card=27, in -mm).  I guess it will get into the kernel when the rest of 
>> v4l synchronizes.
>>    
>>
>
>Nah.  Please review next -mm and send any needed fixes.
>
>  
>
Manuel Capinha was responsible for card=27 patch (Pixelview Pro Ultra).
He is currently testing the patch against newer -mm version and will
submit soon, correcting card numbering.

Mauro.
