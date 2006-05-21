Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWEUJGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWEUJGa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 05:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWEUJGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 05:06:30 -0400
Received: from dd6424.kasserver.com ([85.13.131.51]:52903 "EHLO
	dd6424.kasserver.com") by vger.kernel.org with ESMTP
	id S1751501AbWEUJG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 05:06:29 -0400
Message-ID: <44702D92.3050607@feuerpokemon.de>
Date: Sun, 21 May 2006 11:06:26 +0200
From: dragoran <dragoran@feuerpokemon.de>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: IA32 syscall 311 not implemented on x86_64
References: <44702650.30507@feuerpokemon.de> <20060521085015.GB2535@taniwha.stupidest.org>
In-Reply-To: <20060521085015.GB2535@taniwha.stupidest.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> On Sun, May 21, 2006 at 10:35:28AM +0200, dragoran wrote:
>
>   
>> IA32 syscall 311 from mozilla-xremote not implemented
>> IA32 syscall 311 from firefox-bin not implemented
>> IA32 syscall 311 from mplayer not implemented
>> what is syscall 311  and what effect does this have?
>>     
>
> sys_set_robust_list, I think it's futex related
>   
ok but what does this do and what happens to this apps?
>   
>> I am using 2.6.16-1.2111_FC5 (2.6.16.14)
>>     
>
> probably best to bitch to Red Hat about this
>
>
>   

I did but got no reply yet
