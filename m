Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbTKIQmY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 11:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTKIQmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 11:42:24 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:5762 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262581AbTKIQmX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 11:42:23 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: drivers/ide/pci/adma100.c obsolete?
Date: Sun, 9 Nov 2003 17:47:52 +0100
User-Agent: KMail/1.5.4
References: <20031109081426.GA1287@gondor.apana.org.au>
In-Reply-To: <20031109081426.GA1287@gondor.apana.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311091747.52183.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 of November 2003 09:14, Herbert Xu wrote:
> Hi Bart:
>
> Could you please tell me whether adma100.[ch] is still needed? Nothing
> else seems to refer to them anymore.

Hi,

It is needed, somebody should forward port 2.4.x fixes to make it useful.

PS please cc: linux-ide@vger.kernel.org next time.

