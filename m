Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbVINXnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbVINXnE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 19:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbVINXnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 19:43:03 -0400
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:443 "EHLO
	tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1030296AbVINXnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 19:43:02 -0400
Message-ID: <4328B710.5080503@in.tum.de>
Date: Thu, 15 Sep 2005 01:49:36 +0200
From: Daniel Thaler <thalerd@in.tum.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: michal.k.k.piotrowski@gmail.com
Cc: Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Automatic Configuration of a Kernel
References: <20050914223836.53814.qmail@web51011.mail.yahoo.com> <6bffcb0e05091415533d563c5a@mail.gmail.com>
In-Reply-To: <6bffcb0e05091415533d563c5a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Piotrowski wrote:
> Hi,
> 
> On 15/09/05, Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com> wrote:
> 
>>Hi
>>
>>I wrote this Framework for making a .config based on
>>the System Hardwares. It would be a great help if some
>>people would give me their opinion about it.
>>
>>Regards
> 
> 
> It's for new linux users? They should use distributions kernels.
> It's for "power users"? They just do make menuconfig...
> It's for kernel developers? They just do vi .config.

I like the idea.
I'm a power user and of course I can do make menuconfig, but it would be
useful when building a kernel for new hardware for example.

Currently that involves looking at dmesg output to figure out the correct
options; this would provide a nice base config to work with and reduce the
amount of effort.

Daniel
