Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275263AbTHGKdu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 06:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275265AbTHGKdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 06:33:50 -0400
Received: from soft.uni-linz.ac.at ([140.78.95.99]:60363 "EHLO
	zeus.soft.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id S275263AbTHGKdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 06:33:41 -0400
Message-ID: <3F322AED.6080503@gibraltar.at>
Date: Thu, 07 Aug 2003 12:33:17 +0200
From: Rene Mayrhofer <rene.mayrhofer@gibraltar.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: de-at, de-de, en-gb, en-us
MIME-Version: 1.0
To: Andreas Haumer <andreas@xss.co.at>
CC: herbert@13thfloor.at, Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jason Baron <jbaron@redhat.com>
Subject: Re: pivot_root solved by patch to 2.4.22-pre7
References: <3F309FD8.8090105@gibraltar.at> <Pine.LNX.4.44.0308061633240.2722-100000@logos.cnet> <20030806195101.GB16054@www.13thfloor.at> <3F321D41.1090004@xss.co.at>
In-Reply-To: <3F321D41.1090004@xss.co.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Haumer wrote:
> I just tried it with 2.4.22-rc1, and with this patch I am
> able to umount /initrd/dev and /initrd after pivot_root
> again!
Same for me. With this patch, all the 2.4.21-ac*, 2.4.22-pre*-ac* and 
2.4.22-rc1 kernels I tried work again.

> Don't know yet if it has any ill side effects, though.
Doesn't seem to have, but IANAKG (I am not a kernel guru) ;)

- Rene

