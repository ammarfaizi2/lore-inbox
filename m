Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbUJWNc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUJWNc7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 09:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbUJWNc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 09:32:59 -0400
Received: from vsmtp12.tin.it ([212.216.176.206]:50875 "EHLO vsmtp12.tin.it")
	by vger.kernel.org with ESMTP id S261181AbUJWNcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 09:32:51 -0400
Date: Sat, 23 Oct 2004 15:41:51 +0200
From: Luca Risolia <luca.risolia@studio.unibo.it>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: alan@lxorguk.ukuu.org.uk, luca.risolia@studio.unibo.it, luc@saillard.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Linux 2.6.9-ac3
Message-Id: <20041023154151.418bca53.luca.risolia@studio.unibo.it>
In-Reply-To: <20041022181457.GB8067@bytesex>
References: <20041022101335.6dcf247a.luca.risolia@studio.unibo.it>
	<20041022092102.GA16963@sd291.sivit.org>
	<20041022143036.462742ca.luca.risolia@studio.unibo.it>
	<878y9y269v.fsf@bytesex.org>
	<1098460282.19459.15.camel@localhost.localdomain>
	<20041022181457.GB8067@bytesex>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004 20:14:57 +0200
Gerd Knorr <kraxel@bytesex.org> wrote:

> We'll also need a libv4l2-vendorstuff then (*one* libary for *all* these
> vendor formats), otherwise that isn't going to work.  If someone is
> willing to create & maintain such a library -- fine with me.  I'll
> happily hand out v4l2 vendor format ID's and agree do drop stuff from
> kernel space then.  But asking the apps to decode stuff in userspace
> without providing a way to do so isn't a good idea.

Okay, developers interested in pwc might want to start this library, so
that only a basic driver can be included in the kernel.

Luca Risolia
