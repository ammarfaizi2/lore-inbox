Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267909AbUHPT3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267909AbUHPT3p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 15:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267902AbUHPT3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 15:29:45 -0400
Received: from the-village.bc.nu ([81.2.110.252]:14821 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267786AbUHPT3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 15:29:43 -0400
Subject: Re: PATCH: IDE - fix various comments remove never changing ifdef
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@redhat.com>, linux-ide@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <200408162029.43797.bzolnier@elka.pw.edu.pl>
References: <20040815143546.GA6284@devserv.devel.redhat.com>
	 <200408162029.43797.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092680820.21069.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 16 Aug 2004 19:27:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-16 at 19:29, Bartlomiej Zolnierkiewicz wrote:
> On Sunday 15 August 2004 16:35, Alan Cox wrote:
> > No code changes in this patch just documenting
> 
> If you want to remove FANCY_STATUS_DUMPS define please make
> a separate patch and remove it globally.

Will do.

