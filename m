Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264638AbUEOPun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264638AbUEOPun (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 11:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264639AbUEOPun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 11:50:43 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:56049 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264638AbUEOPuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 11:50:39 -0400
To: Andy Lutomirski <luto@myrealbox.com>
Cc: Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] capabilities, take 3 (Re: [PATCH] capabilites, take 2)
References: <200405131308.40477.luto@myrealbox.com>
	<20040513182010.L21045@build.pdx.osdl.net>
	<200405131945.53723.luto@myrealbox.com>
	<87d657z2lm.fsf@goat.bogus.local> <40A4D49C.3030300@myrealbox.com>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Sat, 15 May 2004 17:50:31 +0200
Message-ID: <87y8ntk7ug.fsf@goat.bogus.local>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Portable Code, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@myrealbox.com> writes:

> BTW, in your capabilities implementation, why do you do:

There's no such thing like "my" capabilities implementation. I use the
capabilities implementation of linux main line as it is. My patch
provides the possibility to connect capabilities to files, nothing
else.

I never tried to fix or modify, how capabilities work.

> If the answer's because that's how Linux cap evolution works, then
> I'd say that Linux cap evolution is broken.

Well, it works for me. :-)

Regards, Olaf.
