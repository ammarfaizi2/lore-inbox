Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbUCFIwU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 03:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbUCFIwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 03:52:20 -0500
Received: from mailgate.uni-paderborn.de ([131.234.22.32]:55255 "EHLO
	mailgate.uni-paderborn.de") by vger.kernel.org with ESMTP
	id S261624AbUCFIwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 03:52:19 -0500
Message-ID: <4049913E.8090600@uni-paderborn.de>
Date: Sat, 06 Mar 2004 09:52:14 +0100
From: Bjoern Schmidt <lucky21@uni-paderborn.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Badness in pci_find_subsys at drivers/pci/search.c:167
References: <40498A7F.5070306@uni-paderborn.de> <521xo6xtn0.fsf@topspin.com>
In-Reply-To: <521xo6xtn0.fsf@topspin.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-UNI-PB_FAK-EIM-MailScanner-Information: Please see http://imap.uni-paderborn.de for details
X-UNI-PB_FAK-EIM-MailScanner: Found to be clean
X-UNI-PB_FAK-EIM-MailScanner-SpamCheck: not spam, SpamAssassin (score=1.594,
	required 4, FROM_ENDS_IN_NUMS 0.87, RCVD_IN_NJABL 0.10,
	RCVD_IN_NJABL_DIALUP 0.53, RCVD_IN_SORBS 0.10)
X-UNI-PB_FAK-EIM-MailScanner-SpamScore: s
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier schrieb:
>     Bjoern> Is there a possibility to find out which device caused
>     Bjoern> this error?  It's the first time that it has been
>     Bjoern> arisen...  The kernels version is v2.6.3, do you need more
>     Bjoern> "input"?
> 
> This is caused by the closed source nvidia driver.  Only nvidia can
> debug this problem.
> 
>  - Roland
> 

Thank you for your answer. Is that a known bug? If not then i'll
send a bug report to nvidia.

-- 
Mit freundlichen Gruessen
Bjoern Schmidt


