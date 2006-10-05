Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWJETV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWJETV2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 15:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWJETV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 15:21:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26846 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750808AbWJETV2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 15:21:28 -0400
Message-ID: <45255B2B.5080303@redhat.com>
Date: Thu, 05 Oct 2006 14:21:15 -0500
From: Eric Sandeen <esandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Peter Osterlund <petero2@telia.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Merge window closed: v2.6.19-rc1
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org> <m38xjuo9lt.fsf@telia.com>
In-Reply-To: <m38xjuo9lt.fsf@telia.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
>> Ok, it's two weeks since v2.6.18, and as a result I've cut a -rc1 release.
> ...
>> so please give it a good testing, and let's see if there are any 
>> regressions.
> 
> The UDF filesystem can't be mounted in read-write mode any more,
> because of forgotten braces.

Urgh.

Thanks...

-Eric
