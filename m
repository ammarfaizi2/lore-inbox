Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292728AbSCINLl>; Sat, 9 Mar 2002 08:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292729AbSCINLb>; Sat, 9 Mar 2002 08:11:31 -0500
Received: from [195.63.194.11] ([195.63.194.11]:30475 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292728AbSCINLV>; Sat, 9 Mar 2002 08:11:21 -0500
Message-ID: <3C8A09BD.7080103@evision-ventures.com>
Date: Sat, 09 Mar 2002 14:10:21 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.6-pre3 boot hangs in ide probing
In-Reply-To: <3C89C3D4.3070004@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Rousselet wrote:
> The motherboard is abit BE6 (4 ide, piix and hpt366) with a pIII 
> coppermine.
> For reference below is dmesg with a booting 2.5.6-pre2.
> 

I observed the same on pre3. But the bug is not ide related,
since the plain ide patches applied on top of pre2 just worked.

(I happen to own the same hpt366 card as you.)

