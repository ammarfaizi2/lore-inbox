Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVFFSBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVFFSBp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 14:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261600AbVFFSBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 14:01:42 -0400
Received: from [81.2.110.250] ([81.2.110.250]:64427 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261622AbVFFSAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 14:00:52 -0400
Subject: Re: Stable 2.6.x.y kernel series...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       stable@kernel.org
In-Reply-To: <42A0DD2F.5060602@pobox.com>
References: <42A0DD2F.5060602@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1118080691.18623.217.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 06 Jun 2005 18:58:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-06-03 at 23:43, Jeff Garzik wrote:
> Just wanted to say in public that I think the stable 2.6.x.y kernel 
> series is working out quite well.  Kudos to the stable@kernel.org team 
> for a job well done.
> 
> The 2.6.x.y series is definitely filling a needed niche.

Ditto, and its been conservative enough that not only does it stay
pretty stable (one partition slip-up so far is very good indeed) its
small enough that most of the add on patches people use aren't breaking
against it either. Even the -ac set just keeps applying barring makefile
just fine so its saved me a ton of work.

Alan

