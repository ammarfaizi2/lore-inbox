Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbTLDR5I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 12:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbTLDR5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 12:57:08 -0500
Received: from ezoffice.mandrakesoft.com ([212.11.15.34]:7091 "EHLO
	vador.mandrakesoft.com") by vger.kernel.org with ESMTP
	id S263281AbTLDR5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 12:57:06 -0500
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: Jason Kingsland <Jason_Kingsland@hotmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux GPL and binary module exception clause?
X-URL: <http://www.linux-mandrake.com/
References: <YPep.5Y5.21@gated-at.bofh.it> <Z3AK-Qw-13@gated-at.bofh.it>
	<3FCF696F.4000605@softhome.net>
From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Organization: MandrakeSoft
Date: Thu, 04 Dec 2003 17:57:04 +0000
In-Reply-To: <3FCF696F.4000605@softhome.net> (Ihar Filipau's message of
 "Thu, 04 Dec 2003 18:05:51 +0100")
Message-ID: <m2d6b4a2kv.fsf@vador.mandrakesoft.com>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ihar 'Philips' Filipau" <filia@softhome.net> writes:

>    GPL is about distribution.
> 
>    e.g. NVidia can distribute .o file (with whatever license they have
> to) and nvidia.{c,h} files (even under GPL license).
>    Then install.sh may do on behalf of user "gcc nvidia.c blob.o -o
> nvidia.ko". Resulting module are not going to be distributed - it is
> already at hand of end-user. So no violation of GPL whatsoever.
> 
>    Licensing is least technical issue regarding modules.
>    But sure I would like to have open source drivers - at least then I
> have chance to clean them up ;-)))

offtopic anyway since nvidia already provide prebuild binaries for
linux at http://www.nvidia.com/object/linux.html ...

