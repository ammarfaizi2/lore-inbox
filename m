Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268095AbUJFGPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268095AbUJFGPL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 02:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268265AbUJFGPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 02:15:10 -0400
Received: from mta10.adelphia.net ([68.168.78.202]:28040 "EHLO
	mta10.adelphia.net") by vger.kernel.org with ESMTP id S268095AbUJFGPF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 02:15:05 -0400
Message-ID: <41638D67.2020307@nodivisions.com>
Date: Wed, 06 Oct 2004 02:15:03 -0400
From: Anthony DiSante <orders@nodivisions.com>
Reply-To: orders@nodivisions.com
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: KVM -> jumping mouse... still no solution?
References: <4163845C.9020900@nodivisions.com> <Pine.LNX.4.61.0410060753590.2993@dragon.hygekrogen.localhost>
In-Reply-To: <Pine.LNX.4.61.0410060753590.2993@dragon.hygekrogen.localhost>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
>>you don't move it, but if you move it N/E/NE it's really slow and jerky, and
>>if you move it S/W/SW even a hair, it slams down to the SW corner of the
>>screen and acts like you hit all the mouse's buttons 50 times simultaneously.
>>
> 
> I've had similar problems with my mouse and KVM switch.
> 
> 
>>The other day I came across this (kerneltrap.org/node/view/2199): "Use
>>psmouse.proto=bare on the kernel command line, or proto=bare on the
>>psmouse module command line."  But that makes the mouse's scroll-wheel not
>>work.  (And this problem doesn't exist with some of the mouse drivers, but it
>>does with IMPS/2, which is the only one I've ever been able to get the scroll
>>wheel working with.)
>>
> 
> psmouse.proto=imps solves the problem for me (wheel works as well).
> The funny thing is that I don't need to do anything like this when I boot 
> a 2.4 kernel, only 2.6 kernels show this behaviour on my system.???

That doesn't make any difference on my system.  Mouse freakout is just the same.

-Anthony DiSante
http://nodivisions.com/
