Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbTJARRo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 13:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbTJARRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 13:17:44 -0400
Received: from mailgate.uni-paderborn.de ([131.234.22.32]:65427 "EHLO
	mailgate.uni-paderborn.de") by vger.kernel.org with ESMTP
	id S262424AbTJARRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 13:17:43 -0400
Message-ID: <3F7B0BFA.1080701@upb.de>
Date: Wed, 01 Oct 2003 19:16:42 +0200
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: de, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ACPI] p2b-ds blacklisted?
References: <blen4v$a42$1@sea.gmane.org> <3F7B0AC2.1040209@pobox.com>
In-Reply-To: <3F7B0AC2.1040209@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please see http://imap.upb.de for details
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-22.5, required 4,
	IDENT_NOBODY 2.90, IN_REP_TO -3.30, QUOTED_EMAIL_TEXT -3.20,
	REFERENCES -6.60, REPLY_WITH_QUOTES -6.50,
	USER_AGENT_MOZILLA_UA -5.80)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> my P2B-DS is blacklisted and the kernel forced acpi=ht. i wonder why 
>> because P2B-D is not blacklisted.
> 
> Asus P2B-D (Dual Pentium2 400 Mhz SMP motherboard) works fine under 
> ACPI, and has worked fine for ages.  I'll be quite disappointed if 
> recent ACPI updates broke it.

No it doesn't. Only P2B-S and P2B-DS are listed. I don't know why yet, 
but i will report if ACPI works fine. I think i'll try this tonight 
although nobody has prophesied me what might happen yet.

Will the kernel just stop booting? or will my machine just crash and 
damage my reiserfs?

