Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbWFSKKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWFSKKl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 06:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWFSKKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 06:10:41 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:39373 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932338AbWFSKKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 06:10:41 -0400
Message-ID: <4496781F.70109@manoweb.com>
Date: Mon, 19 Jun 2006 12:10:39 +0200
From: Alessio Sangalli <alesan@manoweb.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Alessio Sangalli <alesan@manoweb.com>
CC: Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: APM problem after 2.6.13.5
References: <44927F91.6050506@manoweb.com>	 <84144f020606160305ueae2050lc2d8f47944173971@mail.gmail.com>	 <44929CF5.208@manoweb.com> <84144f020606160540q20433601jd9b5331763a55dab@mail.gmail.com> <4492AE3A.7070309@manoweb.com>
In-Reply-To: <4492AE3A.7070309@manoweb.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:98b9443de46bd48dbf34b16449aa5d76
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessio Sangalli wrote:

>>> done:
>>>
>>> 4196c3af25d98204216a5d6c37ad2cb303a1f2bf is first bad commit
>>> diff-tree 4196c3af25d98204216a5d6c37ad2cb303a1f2bf (from
>>> 9092b20803e4b3b3a480592794a73030f17370b3)
>>> Author: Linus Torvalds <torvalds@g5.osdl.org>
>>> Date:   Sun Oct 23 16:31:16 2005 -0700
>>>
>>>     cardbus: limit IO windows to 256 bytes

>> So reverting the above commit from git head makes your box boot again?
>> Linus, any thoughts?
> 
> 
> Yes, exactly. I can run 2.6.17-rc6 with only that commit reverted.

Any news about this problem?

Thank you
Alessio Sangalli



