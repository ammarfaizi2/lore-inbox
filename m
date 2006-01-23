Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030202AbWAWWbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbWAWWbb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 17:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbWAWWbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 17:31:31 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:12559 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S964965AbWAWWbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 17:31:31 -0500
Date: Mon, 23 Jan 2006 23:31:25 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Syed Ahemed <kingkhan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch for CVE-2004-1334 ???
Message-ID: <20060123223125.GU7142@w.ods.org>
References: <3d53b7120601230939p6e8906fbtb196ab49b9b028c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d53b7120601230939p6e8906fbtb196ab49b9b028c5@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 23, 2006 at 11:09:49PM +0530, Syed Ahemed wrote:
> Hi
> I do know this community is busy with more important things , but i am
> out of ideas/search  on this one.
> How do i get the patch for the CVE-2004-1334 ? I have an opensource
> linux 2.4.28 on my production server.

I'm afraid 2.4-hf does not go that far backwards, it started at 2.4.29.
Git started even later. I've searched through http://linux.bkbits.net/
and I think that what you're looking for is here :

http://linux.bkbits.net:8080/linux-2.4/gnupatch@41b76e94BsJKm8jhVtyDat9ZM1dXXg

> If you think this question is stupid enough , then i would eventually
> write a patch for this .The trouble i have is on applying the patch
> cos my understanding of GPL is pretty confusing.

You don't have to worry, unless explicitly stated otherwise, patches
follow the same licence as the code they're for. So basically you can
apply a kernel patch from any other version to your kernel, and if you
know how to fix the bug by yourself (dangerous), that's fine too.

> Please point me to the patch for the above .

Please check above.

> Regards
> King khan

Regards,
Willy

