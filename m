Return-Path: <linux-kernel-owner+w=401wt.eu-S937461AbWLKSgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937461AbWLKSgU (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 13:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763010AbWLKSgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 13:36:20 -0500
Received: from rtsoft3.corbina.net ([85.21.88.6]:35167 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1763007AbWLKSgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 13:36:19 -0500
Date: Mon, 11 Dec 2006 21:36:28 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] [FS_ENET] OF-related update for FEC and SCC MAC's
Message-ID: <20061211213628.23dcc319@vitb.ru.mvista.com>
In-Reply-To: <20061211180048.17991.59030.stgit@localhost.localdomain>
References: <20061211180048.17991.59030.stgit@localhost.localdomain>
Organization: MontaVista software, Inc.
X-Mailer: Sylpheed-Claws 2.0.0cvs8 (GTK+ 2.6.10; i686-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2006 21:00:49 +0300
Vitaly Bordug <vbordug@ru.mvista.com> wrote:

> 
> Updated direct resource pass with ioremap call, make it grant proper IRQ
> mapping, stuff incompatible with the new approach were respectively put  under 
> #ifndef CONFIG_PPC_MERGE.

Hrm, Signed-off-by: missed, I'll resend, sorry about that.
-- 
Sincerely, 
Vitaly
