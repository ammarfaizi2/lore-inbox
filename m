Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263681AbUCUSYw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 13:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263687AbUCUSYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 13:24:52 -0500
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:53863 "EHLO
	smtp-out4.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S263681AbUCUSYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 13:24:51 -0500
Message-ID: <405DDDF3.5000609@blueyonder.co.uk>
Date: Sun, 21 Mar 2004 18:24:51 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RE: 2.6.5-rc2-mm1 x86_64 entry.S errors
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Mar 2004 18:24:50.0795 (UTC) FILETIME=[CC6293B0:01C40F71]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  AS      arch/x86_64/kernel/entry.o
arch/x86_64/kernel/entry.S: Assembler messages:
arch/x86_64/kernel/entry.S:184: Error: missing separator
arch/x86_64/kernel/entry.S:434: Error: missing separator
arch/x86_64/kernel/entry.S:551: Error: missing separator
arch/x86_64/kernel/entry.S:554: Error: missing separator
arch/x86_64/kernel/entry.S:557: Error: missing separator
arch/x86_64/kernel/entry.S:719: Error: missing separator
arch/x86_64/kernel/entry.S:778: Error: missing separator
arch/x86_64/kernel/entry.S:806: Error: missing separator
arch/x86_64/kernel/entry.S:819: Error: missing separator
arch/x86_64/kernel/entry.S:872: Error: missing separator
arch/x86_64/kernel/entry.S:888: Error: missing separator
arch/x86_64/kernel/entry.S:912: Error: missing separator
make[1]: *** [arch/x86_64/kernel/entry.o] Error 1
make: *** [arch/x86_64/kernel] Error 2
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

