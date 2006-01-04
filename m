Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751618AbWADJJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbWADJJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 04:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbWADJJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 04:09:29 -0500
Received: from post.pl ([212.85.96.51]:9461 "HELO v00051.home.net.pl")
	by vger.kernel.org with SMTP id S1751618AbWADJJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 04:09:28 -0500
Message-ID: <43BB906F.3010900@post.pl>
Date: Wed, 04 Jan 2006 10:07:59 +0100
From: "Leonard Milcin Jr." <leonard.milcin@post.pl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: keyboard driver of 2.6 kernel
References: <Pine.LNX.4.60.0601041359380.7341@lantana.cs.iitm.ernet.in> <1136363622.2839.6.camel@laptopd505.fenrus.org>
In-Reply-To: <1136363622.2839.6.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Wed, 2006-01-04 at 14:02 +0530, P.Manohar wrote:
>> Greetings,
>>      I have a small doubt in Linux kernel keyboard driver.
>> In 2.4 kernels the starting fuction of keyboard driver is "handle_scancode". 
>> But in 2.6 kernels the keyboard interface
>> is changed drastically.  If you familiar with that can you tell me the starting 
>> fuction of keyboard interace which gets
>> the scancodes in 2.6 kernels.
>>
>> Actually my paln is to stuff scancodes or keycodes to the keyboard buffer 
>> , from there on the keyboard driver processes them.  I have done this for 
>> 2.4 kernel.  I want to implement the same to 2.6 kernel.
>>
>> Is there any keyloggers which are implemented for 2.6 kernels?
> 
> this is not r00tkitnewbies mailing list 
> 
> keyloggers are evil!

Let's pretend it's some sort of auditing ;-)


Leonard Milcin Jr.

