Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWBBKZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWBBKZV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 05:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWBBKZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 05:25:21 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:16821 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932278AbWBBKZU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 05:25:20 -0500
Message-ID: <43E1DF46.5020803@aitel.hist.no>
Date: Thu, 02 Feb 2006 11:30:30 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?UTF-8?B?RW1pbGlvIEplc8O6cyBHYWxsZWdvIEFyaWFz?= 
	<egallego@babel.ls.fi.upm.es>
CC: Linus Torvalds <torvalds@osdl.org>, Karim Yaghmour <karim@opersys.com>,
       Filip Brcic <brcha@users.sourceforge.net>,
       Glauber de Oliveira Costa <glommer@gmail.com>,
       Thomas Horsten <thomas@horsten.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
References: <Pine.LNX.4.40.0601280826160.29965-100000@jehova.dsm.dk> <43DE57C4.5010707@opersys.com> <5d6222a80601301143q3b527effq526482837e04ee5a@mail.gmail.com> <200601302301.04582.brcha@users.sourceforge.net> <43E0E282.1000908@opersys.com> <Pine.LNX.4.64.0602011414550.21884@g5.osdl.org> <43E1C55A.7090801@drzeus.cx> <Pine.LNX.4.64.0602020044520.21884@g5.osdl.org> <87mzha85sc.fsf@babel.ls.fi.upm.es>
In-Reply-To: <87mzha85sc.fsf@babel.ls.fi.upm.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emilio Jesús Gallego Arias wrote:

>Linus Torvalds <torvalds@osdl.org> writes:
>
>  
>
>>On Thu, 2 Feb 2006, Pierre Ossman wrote:
>>    
>>
>>>The point is not only getting access to the source code, but also being able
>>>to change it. Being able to freely study the code is only half of the beauty
>>>of the GPL. The other half, being able to change it, can be very effectively
>>>stopped using DRM.
>>>      
>>>
>>No it cannot.
>>    
>>
>
>1.- Distribute a kernel with some DRM built-in under the GPL.
>
>2.- Claim that such kernel is an effective technological measure to
>    protect copyright. 
>
>3.- You are no longer free to modify that kernel, (removing the DRM
>    module) or you can be sued under the DMCA, for circumventing an
>    effective technological measure. It doesn't matter in what
>    hardware are you going to run such kernel. The DMCA implicitly
>    imposes an additional restriction to the GPL, but as the
>    restriction is not imposed directly by the copyright owner, but by
>    the law, it's OK as far the GPL is concerned.
>  
>
This can't legally happen.  Do the DMCA prevent "circumventing"
even when you have the legal right to make copies of the content?
(If so, then the music industry breaks DMCA when manufacturing
their protected CDs from a protected master . . .)

If so, then step (1) is illegal because it breaks with the GPL. 
Remember, when you distribute something under the GPL, you cannot
impose restrictions.  It is well established that you can't link in
something with a more restrictive commercial licence, for example. 
I think adding that DRM falls in the same trap - if the DMCA really
impose this additional restriction (because DRM-breaking is illegal
even when content copying is not) then you are not allowed to
add that restriction. 

Someone distributing DRM-protected kernels are breaking
copyrigth law then, if the DMCA is so strict.

Helge Hafting
