Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264931AbUFLVzD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264931AbUFLVzD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 17:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264932AbUFLVzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 17:55:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27052 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264931AbUFLVzA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 17:55:00 -0400
Date: Sat, 12 Jun 2004 18:55:55 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [HPT366] Fix /proc/ide/hpt366 crash
Message-ID: <20040612215555.GB8436@logos.cnet>
References: <20040609112024.GC23623@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040609112024.GC23623@gondor.apana.org.au>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 09:20:25PM +1000, Herbert Xu wrote:
> Hi Marcelo:
> 
> The following patch which fixes fixes the disk spindown problem when
> /proc/ide/hpt366 is read has been in 2.6 for a couple of months.  It
> has just been verified that the same fix is needed and works under
> 2.4 (see http://bugs.debian.org/250171).

Applied, thanks Herbert.
