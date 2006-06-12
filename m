Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751857AbWFLLGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbWFLLGx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 07:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbWFLLGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 07:06:53 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:55902 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1751857AbWFLLGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 07:06:53 -0400
Message-ID: <448D4AC7.4040009@tls.msk.ru>
Date: Mon, 12 Jun 2006 15:06:47 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Wu Fengguang <wfg@mail.ustc.edu.cn>, Michael Tokarev <mjt@tls.msk.ru>,
       Ingo Oeser <ioe-lkml@rameria.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH 4/5] readahead: backoff on I/O error
References: <20060609080801.741901069@localhost.localdomain> <349840680.03819@ustc.edu.cn> <200606102033.46844.ioe-lkml@rameria.de> <448B221D.3080907@tls.msk.ru> <350074764.23563@ustc.edu.cn>
In-Reply-To: <350074764.23563@ustc.edu.cn>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang wrote:
[]
> Andrew:
> I was a bit afraid about that because I have no CDROM to try it out.
> But since Michael has tested it OK, it should be OK for the stable kernel.

Hmm.. I haven't "tested it OK" yet. I just ran a quick-n-dirty
check.  Tomorrow I'll be in our office where I have more adequate
"test environment" for this stuff (different CD/DVD drives and
disks, some scratched), and I'll do some real testing.

Thanks.

/mjt

