Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWGaTzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWGaTzw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 15:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWGaTzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 15:55:51 -0400
Received: from ns2.g-housing.de ([81.169.133.75]:14744 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S1751285AbWGaTzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 15:55:51 -0400
Date: Mon, 31 Jul 2006 20:55:31 +0100 (BST)
From: Christian Kujau <evil@g-house.de>
X-X-Sender: evil@sheep.housecafe.de
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: minor typo fixes in md.txt
In-Reply-To: <20060731091155.5763dcc3.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.64.0607311749570.8276@sheep.housecafe.de>
References: <Pine.LNX.4.64.0607311300080.2482@prinz64.housecafe.de>
 <20060731091155.5763dcc3.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006, Randy.Dunlap wrote:
> Attachments make review/feedback more difficult and less likely.

ACK, sorry.

> However, it is common (and hence not a problem) to use
> 2 spaces after a period (full stop) at the end of a sentence,
> so I would prefer that those parts of the patch be dropped.

Um, really? I've never seen this before...but then again I'm not a 
native english speaker, but I still find it annoying...hm, but that's no 
reason, right :-)

> -desipite possible corruption.  This is normally done with
> +desipite possible corruption. This is normally done with
> despite

ACK.

> Fix indentation/alignment.

The indentation of this file is...."interesting" and I did not dare to 
touch it, I thought it had some special meaning....

Anyway, I'll return to more important issues then, maybe Ingo just want 
to scratch one of the "level" explanations, this *is* confusing. But 
above all, I was really impressed to find all the sysfs-switches 
documented and now I know what this debian-checkarray script was up 
to...

Thanks,
Christian
-- 
BOFH excuse #198:

Post-it Note Sludge leaked into the monitor.
