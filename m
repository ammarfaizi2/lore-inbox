Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317037AbSGSVjJ>; Fri, 19 Jul 2002 17:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317056AbSGSVjI>; Fri, 19 Jul 2002 17:39:08 -0400
Received: from armitage.toyota.com ([63.87.74.3]:16774 "EHLO
	armitage.toyota.com") by vger.kernel.org with ESMTP
	id <S317037AbSGSVjI>; Fri, 19 Jul 2002 17:39:08 -0400
Message-ID: <3D3887AC.2080302@lexus.com>
Date: Fri, 19 Jul 2002 14:42:04 -0700
From: J Sloan <jjs@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: anton wilson <anton.wilson@camotion.com>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 O(1) scheduler
References: <200207191943.PAA00351@test-area.com> <3D386E70.4040401@lexus.com> <200207192018.QAA19141@test-area.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I can't speak for Alan, Andrea or
Red Hat, but their respective kernels
are all likely to be kept pretty well up
to date on the current O(1) - that's
certainly the case AFAICT -

Joe

anton wilson wrote:

>On Friday 19 July 2002 03:54 pm, J Sloan wrote:
>  
>
>>Use 2.4-aa, 2.4-ac or 2.4-redhat kernel
>>and you get the O(1) secheduler at
>>no extra cost -
>>
>>    
>>
>
>
>  
>
>>Joe
>>    
>>
>
>
>I'm actually worried not about just the O(1) scheduler but if these patches 
>will be incorporating the O(1) bug fixes such as the serious one in 
>balance_load where curr->next was used instead of current->prev. Also, I need 
>to use a patch that won't tamper with the usb implementation because I'd have 
>to update our current usb driver to fit into the new system, and I'm getting 
>flack about wasting time trying to update that thing already . . . So if you 
>tell me no, I can go tell my boss I have to update the usb driver.
>
>
>Anton
>
>  
>

