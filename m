Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263942AbUENHJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263942AbUENHJV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 03:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263898AbUENHJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 03:09:21 -0400
Received: from moutng.kundenserver.de ([212.227.126.189]:44783 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263942AbUENHJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 03:09:19 -0400
To: Valdis.Kletnieks@vt.edu
Cc: Chris Wright <chrisw@osdl.org>, Andy Lutomirski <luto@myrealbox.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] capabilites, take 2
References: <200405131308.40477.luto@myrealbox.com>
	<20040513182010.L21045@build.pdx.osdl.net>
	<200405140135.i4E1Zp7A025139@turing-police.cc.vt.edu>
	<874qqj1sk3.fsf@goat.bogus.local>
	<200405140604.i4E64ikK008021@turing-police.cc.vt.edu>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Fri, 14 May 2004 09:09:11 +0200
In-Reply-To: <200405140604.i4E64ikK008021@turing-police.cc.vt.edu> (Valdis
 Kletnieks's message of "Fri, 14 May 2004 02:04:44 -0400")
Message-ID: <87u0yjzdrc.fsf@goat.bogus.local>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Portable Code, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu writes:

> On Fri, 14 May 2004 07:33:32 +0200, Olaf Dietsche said:
>
>> Seems like you're not aware of:
>> <http://www.olafdietsche.de/linux/capability/>
>> 
>> This supports filesystem capabilities with the current (POSIX?)
>> implementation.

This refers to the linux kernel main line.

> Yes.. I was aware of that.. and I just visited it.. and the VERY TOP it says:
>
> "Filesystem capabilities for linux
>
> This implementation is likely *not* POSIX compatible."

This refers to the tools I provide. I should emphasize this on the
page, thank you. My patch doesn't change the rules, how the capability
bits are mingled.

> Now who should I believe, you or the author of the page? :)

Alright, I deserve this for being imprecise. :)

Regards, Olaf.
