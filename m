Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbUBYU4A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 15:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbUBYUzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 15:55:35 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:28389 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S261468AbUBYUus
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 15:50:48 -0500
Message-ID: <403D0A7E.6080500@stesmi.com>
Date: Wed, 25 Feb 2004 21:50:06 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] fix Silicon Image SATA 4-port support
References: <403C4E73.9030805@pobox.com> <403C8EDC.1030905@stesmi.com> <403CF946.2080708@pobox.com>
In-Reply-To: <403CF946.2080708@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff.

>>> Do not be fooled, Silicon Image is still marked CONFIG_BROKEN for a 
>>> reason...  :)  But this should (hopefully!) get 4-port support going.
>>>
>>> Testing requested...
>>
>> Care to elaborate on what's left to do until you're satisfied with it?
>>
>> And are the issues general (all chips) or specific to some chips?
> 
> Just specific to Silicon Image, which is the only thing marked 
> CONFIG_BROKEN.  It needs to acknowledge more interrupts than it 
> currently does.
> 
>     Jeff
> 
> 

Ok, the question was "specific to all SiI chips or only to some, or
maybe only to some boards or revisions" since it was about SiI...

But I take your second sentance to mean all chips and boards.

// Stefan

