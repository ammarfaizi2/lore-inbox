Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964981AbVJUPXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbVJUPXs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 11:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbVJUPXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 11:23:47 -0400
Received: from [195.23.16.24] ([195.23.16.24]:15811 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S964983AbVJUPXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 11:23:44 -0400
Message-ID: <4359078E.2010101@grupopie.com>
Date: Fri, 21 Oct 2005 16:21:50 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Vincent W. Freeh" <vin@csc.ncsu.edu>
CC: arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Understanding Linux addr space, malloc, and heap
References: <4358F0E3.6050405@csc.ncsu.edu> <1129903396.2786.19.camel@laptopd505.fenrus.org> <4359051C.2070401@csc.ncsu.edu>
In-Reply-To: <4359051C.2070401@csc.ncsu.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> On Fri, 2005-10-21 at 09:45 -0400, Vincent W. Freeh wrote:
>> I cannot mprotect data that I malloc ...

 > Arjan van de Ven wrote:
>> you can't mprotect malloc() memory period ..

Vincent W. Freeh wrote:
> Actually, I can and do.  Simple program at end.

Am I the only one who finds this conversation weird? :)

This reminds me of a student I had that called "main" to return to the 
start of the application. No matter how I explained that it was simply 
wrong and that stack was growing because of that he just kept replying: 
"but it works!"...

-- 
Paulo Marques - www.grupopie.com

The rule is perfect: in all matters of opinion our
adversaries are insane.
Mark Twain
