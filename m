Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263025AbUKYJgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbUKYJgE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Nov 2004 04:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263027AbUKYJgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Nov 2004 04:36:04 -0500
Received: from knserv.hostunreachable.de ([212.72.163.70]:3741 "EHLO
	mail.hostunreachable.de") by vger.kernel.org with ESMTP
	id S263025AbUKYJgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Nov 2004 04:36:01 -0500
Message-ID: <41A599CB.9070800@syncro-community.de>
Date: Thu, 25 Nov 2004 09:37:31 +0100
From: Hendrik Wiese <7.e.Q@syncro-community.de>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Davide Rossetti <davide.rossetti@roma1.infn.it>,
       LKLM <linux-kernel@vger.kernel.org>
Subject: Re: Difference wait_event_interruptible and interruptible_wait_on
References: <41A478F2.3080004@syncro-community.de>	 <41A48CFB.2010304@roma1.infn.it>  <41A48FC2.6010701@syncro-community.de> <1101306293.2811.18.camel@laptop.fenrus.org>
In-Reply-To: <1101306293.2811.18.camel@laptop.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>On Wed, 2004-11-24 at 14:42 +0100, Hendrik Wiese wrote:
>
>  
>
>>So what should such a condition be? What should be put there?
>>    
>>
>
>depends on your code.. do you have an URL to your driver source so that
>people can see what you're asking ?
>
>
>
>  
>
It is a proprietary driver developed for access to passive and active 
modules inside a vme-rack. Active modules can communicate with each 
other over an IP layer created by the driver on top of the VME 
architecture (dual port ram, Tundra Universe II PCI-VME Bridge) and on 
the other hand a device for communication between active and passive 
modules. I don't know if I may make the source code public, 'cos it is 
property of my employer. I have to communicate this. I know there is 
something called GPL and I also know what it means, but I fear my 
oppinion won't be heard by my employer. Well... it's worth a try.
