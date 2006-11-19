Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933424AbWKSWTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933424AbWKSWTV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 17:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933463AbWKSWTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 17:19:21 -0500
Received: from port254.ds1-he.adsl.cybercity.dk ([217.157.198.197]:9771 "EHLO
	gere.msconsult.dk") by vger.kernel.org with ESMTP id S933424AbWKSWTU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 17:19:20 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Oleg Verych <olecom@flower.upol.cz>, linux-kernel@vger.kernel.org,
       rasmus@msconsult.dk (=?utf-8?q?Rasmus_B=C3=B8g_Hansen?=)
Subject: Re: smbfs (Re: BUG: soft lockup detected on CPU#0! (2.6.18.2))
References: <867ixyvum6.fsf@gere.msconsult.dk>
	<slrnelofru.7lr.olecom@flower.upol.cz>
	<20061117145342.f566a62a.akpm@osdl.org>
From: rasmus@msconsult.dk (=?utf-8?q?Rasmus_B=C3=B8g_Hansen?=)
Date: Sun, 19 Nov 2006 23:18:57 +0100
In-Reply-To: <20061117145342.f566a62a.akpm@osdl.org> (Andrew Morton's
 message of "Fri, 17 Nov 2006 14:53:42 -0800")
Message-ID: <86hcwvaxm6.fsf@gere.msconsult.dk>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Organization: MS Consult
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-MSC-MailScanner: Found to be clean
X-MSC-MailScanner-From: rasmus@msconsult.dk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Thu, 16 Nov 2006 10:30:41 +0000 (UTC)
> Oleg Verych <olecom@flower.upol.cz> wrote:
>
>> [ Adding e-mail of Andrew Morton, he may have clue about who to ping ;]
>> [ MAINTAINERS.smbfs seems to be emply                                 ]
>
> smbfs is unmaintained and we'd like to kill it off.  Please use cifs.

Oh, I wasn't aware that CIFS had become stable enough and smbfs was
deprecated.

I will begin migration to cifs.

Thanks.

Regards
/Rasmus

-- 
Rasmus Bøg Hansen
MSC Aps
Bøgesvinget 8
2740 Skovlunde
44 53 93 66

