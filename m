Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271529AbRICRu2>; Mon, 3 Sep 2001 13:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271551AbRICRuS>; Mon, 3 Sep 2001 13:50:18 -0400
Received: from [216.151.155.121] ([216.151.155.121]:62470 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S271529AbRICRuM>; Mon, 3 Sep 2001 13:50:12 -0400
To: David Woodhouse <dwmw2@infradead.org>
Cc: psusi@cfl.rr.com, linux-kernel@vger.kernel.org
Subject: Re: [bug report] NFS and uninterruptable wait states
In-Reply-To: <m3zo8cp93a.fsf@belphigor.mcnaught.org>
	<01090310483100.26387@faldara> <32526.999534512@redhat.com>
From: Doug McNaught <doug@wireboard.com>
Date: 03 Sep 2001 13:50:09 -0400
In-Reply-To: David Woodhouse's message of "Mon, 03 Sep 2001 17:28:32 +0100"
Message-ID: <m3ofosp3ji.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> writes:

> /me tries to work out why anyone would ever want filesystem accesses to be 
> uninterruptible.

Hmmm, "because V6 did it that way"?  It was probably significantly
faster back in those days...

;)

-Doug
-- 
Free Dmitry Sklyarov! 
http://www.freesklyarov.org/ 

We will return to our regularly scheduled signature shortly.
