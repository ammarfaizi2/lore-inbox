Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263879AbUDFPtu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 11:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263871AbUDFPtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 11:49:49 -0400
Received: from ulysses.news.tiscali.de ([195.185.185.36]:2572 "EHLO
	ulysses.news.tiscali.de") by vger.kernel.org with ESMTP
	id S263876AbUDFPsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 11:48:38 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Thomas Bach <blox@tiscali.de>
Newsgroups: linux.kernel
Subject: Re: Workaround for ReiserFS on root-filesystem
Date: Mon, 05 Apr 2004 22:28:05 +0200
Organization: Tiscali Germany
Message-ID: <c4ujgl$28qq$1@ulysses.news.tiscali.de>
References: <1I0Gz-63o-3@gated-at.bofh.it> <1I0Gz-63o-5@gated-at.bofh.it> <1I0Gz-63o-1@gated-at.bofh.it> <1I0Qg-6b0-5@gated-at.bofh.it>
NNTP-Posting-Host: p213.54.49.246.tisdip.tiscali.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: ulysses.news.tiscali.de 1081266517 74586 213.54.49.246 (6 Apr 2004 15:48:37 GMT)
X-Complaints-To: abuse@tiscali.de
NNTP-Posting-Date: Tue, 6 Apr 2004 15:48:37 +0000 (UTC)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040317
X-Accept-Language: de-de, de, en
In-Reply-To: <1I0Qg-6b0-5@gated-at.bofh.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Torcz wrote:
> On Mon, Apr 05, 2004 at 09:57:48PM +0200, Thomas Bach wrote:
> 
>>Daniel Andersen wrote:
>>
>>>>I use ReiserFS for my root-filesystem while trying to upgrade to a newer
>>>>kernel-version (still using 2.4.20) I got a error, that / could not be
>>>>remounted read/write. After googling a bit I stumbled over the fact that
>>>>ReiserFS as root-filesystem doesn't work since version 2.4.22 (or
>>>>something like this).
 >
>  It works for me here:
> 
> /dev/ide/host0/bus0/target0/lun0/part4 on / type reiserfs (rw,sync)
> 
> Linux mother 2.6.5 #10 Sun Apr 4 08:59:08 CEST 2004 i686 unknown unknown GNU/Linux
> 
> It always worked - with 2.4.x, 2.5.x, 2.6.x up to 2.6.5.

OK! I am a bit confused. Could you perhaps pass me your /etc/fstab and 
grub.conf/lilo.conf entrys?

Thanks,
Thomas Bach (hopefull that he hasn't to reinstall all this stuff here)

