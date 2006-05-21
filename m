Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWEUJ0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWEUJ0A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 05:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWEUJ0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 05:26:00 -0400
Received: from dd6424.kasserver.com ([85.13.131.51]:30123 "EHLO
	dd6424.kasserver.com") by vger.kernel.org with ESMTP
	id S932333AbWEUJZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 05:25:59 -0400
Message-ID: <44703229.20702@feuerpokemon.de>
Date: Sun, 21 May 2006 11:26:01 +0200
From: dragoran <dragoran@feuerpokemon.de>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: IA32 syscall 311 not implemented on x86_64
References: <44702650.30507@feuerpokemon.de> <20060521085015.GB2535@taniwha.stupidest.org> <44702D92.3050607@feuerpokemon.de> <20060521091139.GB3468@taniwha.stupidest.org>
In-Reply-To: <20060521091139.GB3468@taniwha.stupidest.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> On Sun, May 21, 2006 at 11:06:26AM +0200, dragoran wrote:
>
>   
>> ok but what does this do and what happens to this apps?
>>     
>
> my guess is they fallback to something else and still work, but it's
> only a guess
>
>   
>> I did but got no reply yet
>>     
>
> does it happen with a mainline kernel?  a quick scan of the code shows
> that syscall is wired up
>
>
>   
the weird thing is that it suddenly started to appear (no kernel update)
can it be prelink related?
