Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290796AbSCOLVn>; Fri, 15 Mar 2002 06:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290120AbSCOLV2>; Fri, 15 Mar 2002 06:21:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17163 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291272AbSCOLSs>;
	Fri, 15 Mar 2002 06:18:48 -0500
Message-ID: <3C91D885.509@mandrakesoft.com>
Date: Fri, 15 Mar 2002 06:18:29 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Stelian Pop <stelian.pop@fr.alcove.com>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] BK ignore list
In-Reply-To: <20020315110152.GF13625@come.alcove-fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop wrote:

>Hi Marcelo,
>
>This patch (send as a regular not a bk patch since for some
>reason bitkeeper doesn't like changesets which modify files 
>under BitKeeper/...) backports the exclusion patterns from
>Linus' 2.5 BK repository.
>
>With this patch, bk citool can really be used :-)
>
>Stelian.
>
>===== BitKeeper/etc/ignore 1.1 vs edited =====
>--- 1.1/BitKeeper/etc/ignore	Tue Feb  5 18:30:56 2002
>+++ edited/BitKeeper/etc/ignore	Fri Mar 15 11:42:52 2002
>
You beat me to it :)

I was in fact just about to send the same thing along to Marcelo.

Thanks,

    Jeff






