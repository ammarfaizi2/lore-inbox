Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262340AbVBKVIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbVBKVIu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 16:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbVBKVIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 16:08:50 -0500
Received: from mail02.hansenet.de ([213.191.73.62]:26772 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S262340AbVBKVHw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 16:07:52 -0500
Message-ID: <420D1EB4.3080704@web.de>
Date: Fri, 11 Feb 2005 22:08:04 +0100
From: Marcus Hartig <m.f.h@web.de>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to disable slow agpgart in kernel config?
References: <420C4B9A.6020900@web.de> <20050211062100.GB1782@redhat.com> <420CDB93.70506@web.de> <20050211184604.GB15721@redhat.com>
In-Reply-To: <20050211184604.GB15721@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

  > *shrug*, if the nvidia module is properly configured, it should make
> no difference at all. AGPGART operation isn't a performance critical
> thing, as the hardware does 99% of the work.

Yes, that was also my opinion, but after using AGPGART, hmm.

And it was on my last 32 bit FC2 systems with other hardware the same slow 
operations on the desktop. And I'm not alone, there are some nvnews.net 
linux forum users which report the same slow performance with AGPGART.

Maybe the linux kernel AGPGART do not run well with the nVidia 2D 
acceleration renderer or the kernel driver and is a nvidia problem.

http://www.marcush.de/Xorg.0.log

Greetings,
Marcus

