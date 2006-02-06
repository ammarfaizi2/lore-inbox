Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWBFRnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWBFRnF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 12:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWBFRnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 12:43:05 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:33756 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932261AbWBFRnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 12:43:04 -0500
Message-ID: <43E78AA0.2090900@sgi.com>
Date: Mon, 06 Feb 2006 18:42:56 +0100
From: Jes Sorensen <jes@sgi.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Chow <davidchow@shaolinmicro.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux drivers management
References: <43E71AD7.5070600@shaolinmicro.com> <yq0d5i0ol4i.fsf@jaguar.mkp.net> <43E77EEA.7040908@shaolinmicro.com>
In-Reply-To: <43E77EEA.7040908@shaolinmicro.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Chow wrote:
>> This is a classic question, by seperating out the drivers you make it
>> so much harder for all developers to propagate changes into all pieces
>> of the tree.
> 
> I write drivers, never need to change kernel if the kernel API is mature 
> enough to provide the need of a module developer needs. There is no 
> reason to make changes to the kernel source, only needed because the 
> original kernel code is crap or the API designed without proper 
> software/system architectural design work effort. Each Linux kernel 
> version go through a lengthy beta release cycle (e.g. 2.3, 2.5, 2.7), 
> this shouldn't happen and idea collection should be enough through this 
> large Linux community.

Silly me, it was a trick question. I should have known better than to
fall into that trap. See the responses you got from other people already
and go check out the archives.

No even better, here's a link:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=Documentation/stable_api_nonsense.txt

If you still wish to argue for this, please take me off the CC list.
To be honest, I don't think anyone on linux-kernel is interested in yet
another round of this one.

Cheers,
Jes
