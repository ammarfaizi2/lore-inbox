Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUDFNOx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 09:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbUDFNOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 09:14:53 -0400
Received: from ulysses.news.tiscali.de ([195.185.185.36]:62475 "EHLO
	ulysses.news.tiscali.de") by vger.kernel.org with ESMTP
	id S263806AbUDFNOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 09:14:52 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Thomas Bach <blox@tiscali.de>
Newsgroups: linux.kernel
Subject: Workaround for ReiserFS on root-filesystem
Date: Mon, 05 Apr 2004 19:54:16 +0200
Organization: Tiscali Germany
Message-ID: <c4uag9$270t$1@ulysses.news.tiscali.de>
NNTP-Posting-Host: p213.54.49.246.tisdip.tiscali.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: ulysses.news.tiscali.de 1081257290 72733 213.54.49.246 (6 Apr 2004 13:14:50 GMT)
X-Complaints-To: abuse@tiscali.de
NNTP-Posting-Date: Tue, 6 Apr 2004 13:14:50 +0000 (UTC)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040317
X-Accept-Language: de-de, de, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks!

I use ReiserFS for my root-filesystem while trying to upgrade to a newer 
kernel-version (still using 2.4.20) I got a error, that / could not be 
remounted read/write. After googling a bit I stumbled over the fact that 
ReiserFS as root-filesystem doesn't work since version 2.4.22 (or 
something like this).

So I asked myself if there exists any workaround/howto/something-else so 
   I could get away from making my root-fs to an ext3 one. Does anyone 
know something about it?

Thanks,
	Thomas Bach
