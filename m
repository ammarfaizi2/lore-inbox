Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271293AbTGWUPH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 16:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271297AbTGWUPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 16:15:04 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:49660 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271293AbTGWUOp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 16:14:45 -0400
Subject: Re: 2.4.22-pre7: are security issues solved?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030723201619.GA21303@pc.aurel32>
References: <Pine.LNX.4.44.0307212234390.3580-100000@localhost.localdomain>
	 <E19fGMZ-0000Zm-00@gondolin.me.apana.org.au>
	 <20030723033505.145db6b8.davem@redhat.com>
	 <20030723104753.GA2479@gondor.apana.org.au>
	 <20030723035022.23a75bc5.davem@redhat.com>
	 <20030723105903.GA2582@gondor.apana.org.au>
	 <20030723201619.GA21303@pc.aurel32>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058991781.5520.133.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jul 2003 21:23:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-23 at 21:16, Aurelien Jarno wrote:
> Or maybe it is possible to update this information with a longer period.
> Let's say for example 5 seconds. So it is almost impossible to determine
> the length of a password.

In some cases that is still useful information. People brought up the
IRQ data and to be honest that also is something I'd prefer wasn't non 
root viewable.

