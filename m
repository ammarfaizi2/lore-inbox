Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262616AbVAVRfC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262616AbVAVRfC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 12:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbVAVRfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 12:35:00 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:21656 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S262616AbVAVRdl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 12:33:41 -0500
Message-ID: <41F28E6A.6040806@tiscali.de>
Date: Sat, 22 Jan 2005 18:33:30 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 4081] New: OpenOffice crashes while starting due to a threading
 error
References: <217740000.1106412985@[10.10.2.4]>
In-Reply-To: <217740000.1106412985@[10.10.2.4]>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:

>Please contact bug submitter for more info, not myself.
>
>---------------------------------------------
>
>http://bugme.osdl.org/show_bug.cgi?id=4081
>
>           Summary: OpenOffice crashes while starting due to a threading
>                    error
>    Kernel Version: 2.6.11-rc2
>            Status: NEW
>          Severity: blocking
>             Owner: process_other@kernel-bugs.osdl.org
>         Submitter: diego@pemas.net
>
>
>Distribution: Debian
>Hardware Environment: Pentum III 733 MHz
>Software Environment: Debian Sid
>Problem Description:
>While starting open Office crashes, it did not happend on 2.6.10, but happend on
>2.6.11. rc1 and rc2. The only thing that has changed is the kernel. If i go back
>to 2.6.10 OpenOffice starts just fine.
>
>gdb shows that it crashes during this call:
>thread_get_info_callback: cannot get thread info: generic error
>
>the logs kern.log and messages don't show anything related to this crash.
>
>Steps to reproduce:
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Hi!
I'm suing Arch Linux and the Kernel 2.6.11-rc2 -- it works great. Try to 
recompile your OO.org.

Matthias-Christian Ott
