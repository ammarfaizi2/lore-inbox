Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVCCBkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVCCBkn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 20:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVCCBga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 20:36:30 -0500
Received: from mercury.sdinet.de ([193.103.161.30]:53634 "EHLO
	mercury.sdinet.de") by vger.kernel.org with ESMTP id S261296AbVCCBe5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 20:34:57 -0500
Date: Thu, 3 Mar 2005 02:34:56 +0100 (CET)
From: Sven-Haegar Koch <haegar@sdinet.de>
To: Massimo Cetra <mcetra@navynet.it>
Cc: "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: Kernel release numbering
In-Reply-To: <20050303010615.3C7F184008@server1.navynet.it>
Message-ID: <Pine.LNX.4.62.0503030222520.11715@mercury.sdinet.de>
References: <20050303010615.3C7F184008@server1.navynet.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2005, Massimo Cetra wrote:

> Linus Torvalds wrote:
>
>> Namely that we could adopt the even/odd numbering scheme that
>> we used to do on a minor number basis, and instead of
>> dropping it entirely like we did, we could have just moved it
>> to the release number, as an indication of what was the
>> intent of the release.
>
>> Comments?
>
> This is surely a good idea because end users (not developers) like me would
> have greater possibility not to occur in a regression with an even release.

What I would like to see as an enduser is (dreaming):
 	kernel 2.6.x - last released

 	often released (every 1-2 weeks) kernel 2.6.x.z
 	containing just the answers to the often repeating
 	lkml questions which are answered with "use $this simple patch"

 	kernel 2.6.y-pre/rc/bk - development, working towards 2.6.y

in practice your proposed 2.6.even changes, but these continued until the 
next kernel is released, not stopped after 1-2 weeks with the worst fixes.
(a bit like the -as series, but with the "official blessing")

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)
