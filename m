Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWCVErT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWCVErT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 23:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWCVErT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 23:47:19 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:17314 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750757AbWCVErS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 23:47:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GHHBFRiTRxVXv4Cm77hKJxYcE9A/RLWXtxv7Hjim0S2I8ekAj8wsdnJlzjRfNAWQvy+BRaqxl88f9AlrL1lFC1PD++ST6ZreNyKZMFvLJ11kYc3rPryFk1HajcvKxfcSAcJG5gNGSZ+FdlwljajXTqmeDZxKEcaugLW+chamdyo=
Message-ID: <489ecd0c0603212047q6236d940m7f5ec7e2e334ec61@mail.gmail.com>
Date: Wed, 22 Mar 2006 12:47:17 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH 1/2]Blackfin archtecture patche for 2.6.16
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060321194848.4d041ab5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <489ecd0c0603200200va747a68k187651930a3f0a51@mail.gmail.com>
	 <20060321031457.69fa0892.akpm@osdl.org>
	 <489ecd0c0603211945m14e9656bm5daf1e62eeca56a@mail.gmail.com>
	 <20060321194848.4d041ab5.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

   This is the patch of MAINTAINERS entry. As more Blackfin drivers
added in, I'll add more maintainers list.

diff --git a/MAINTAINERS b/MAINTAINERS
index 8db5c33..649cb01 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -425,6 +425,36 @@ M: tigran@veritas.com
 L:     linux-kernel@vger.kernel.org
 S:     Maintained

+BLACKFIN ARCHITECTURE
+P:     Luke Yang
+M:     luke.adi@gmail.com
+P:     Aubery Li
+M:     aubery.li@analog.com
+P:     Bernd Schmidt
+M:     bernd.schmidt@analog.com
+P:     Robin Getz
+M:     robin.retz@analog.com
+P:     Michael Hennerich
+M:     michael.hennerich@analog.com
+P:     Jie Zhang
+M:     jie.zhang@analog.com
+P:     Michael Kang
+M:     michael.kang@analog.com
+P:     Roy Huang
+M:     roy.huang@analog.com
+P:     Sonic Zhang
+M:     sonic.zhang@analog.com
+L:     linux-kernel@vger.kernel.org
+W:     http://blackfin.uclinux.org
+S:     Supported
+
+BLACKFIN SERIAL DRIVER
+P:     Sonic Zhang
+M:     sonic.zhang@analog.com
+L:     linux-kernel@vger.kernel.org
+W:     http://blackfin.uclinux.org
+S:     Supported
+
 BLOCK LAYER
 P:     Jens Axboe
 M:     axboe@suse.de

signed-off-by: Luke Yang <luke.adi@gmail.com>

Regards,
Luke Yang

On 3/22/06, Andrew Morton <akpm@osdl.org> wrote:
> "Luke Yang" <luke.adi@gmail.com> wrote:
> >
> >  >   The lack of a MAINTAINERS entry doesn't inspire confidence..
> >     As Bernd said, Analog Device has a group maintaining linux for
> >  Blackfin. Now I am the one who in charge of committing patches into
> >  mainline, other developers may do the same thing later.  By
> >  MAINTAINERS entry do you mean the linux-2.6/MAINTAINER? Or shall I
> >  list maintainers name in the patch mail?
>
> I was referring to an update to the MAINTAINERS file.
>


--
Best regards,
Luke Yang
magic.yyang@gmail.com; luke.adi@gmail.com
