Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266517AbUINBoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266517AbUINBoA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 21:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269099AbUINBoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 21:44:00 -0400
Received: from relay.pair.com ([209.68.1.20]:48652 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S266517AbUINBn6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 21:43:58 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <41464C8E.3060004@kegel.com>
Date: Mon, 13 Sep 2004 18:42:38 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix allnoconfig on arm with small tweak to kconfig?
References: <414551FD.4020701@kegel.com> <20040913091534.B27423@flint.arm.linux.org.uk> <4145BB30.60309@kegel.com> <20040913195119.B4658@flint.arm.linux.org.uk>
In-Reply-To: <20040913195119.B4658@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> If you want something that's guaranteed to work, use one of the
> per-platform default configurations.  Nothing else carries any
> guarantee what so ever on ARM.

I did give that a shot, but every one I tried seemed to be
broken.  (I may have been using a too-new compiler, and I probably
suffer from impatient newbie-itis.)  Can you suggest which commands
to use to retrieve a working default configuration?

Thanks,
Dan


-- 
My technical stuff: http://kegel.com
My politics: see http://www.misleader.org for examples of why I'm for regime change
