Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbTKONOt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 08:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbTKONOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 08:14:43 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:62882 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261692AbTKONOV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 08:14:21 -0500
Message-ID: <3FB626A9.20904@cyberone.com.au>
Date: Sun, 16 Nov 2003 00:14:17 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: azarah@nosferatu.za.org
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nick's scheduler v19
References: <1065350173.4946.5.camel@pilot.stavtrup-st.dk>	 <3F80DF3C.8010406@cyberone.com.au> <3F81123F.4040609@cyberone.com.au>	 <3F811E02.3060803@cyberone.com.au>  <3F8140CF.9050603@cyberone.com.au>	 <1065612151.4782.4.camel@pilot.stavtrup-st.dk>	 <3F9907EB.7050700@cyberone.com.au>	 <1067175079.664.7.camel@pilot.stavtrup-st.dk>	 <3FB5EE6A.8080801@cyberone.com.au> <1068899953.5033.1.camel@nosferatu.lan>
In-Reply-To: <1068899953.5033.1.camel@nosferatu.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin Schlemmer wrote:

>On Sat, 2003-11-15 at 11:14, Nick Piggin wrote:
>
>
>>Its against mm3 but I can do a patch against Linus' tree.
>>
>>
>
>Would be appreciated, especially if you are going to keep doing
>it against the -mm tree.
>
>

Yep, I've done that for v19a which is what you should be using ;)

The conflict in the trees is the preempt context switch accounting patch
which seems like it might not it before 2.6.0.


