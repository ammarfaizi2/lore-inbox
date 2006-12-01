Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162153AbWLAWpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162153AbWLAWpW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 17:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162155AbWLAWpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 17:45:22 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46560 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1162153AbWLAWpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 17:45:20 -0500
Date: Fri, 1 Dec 2006 22:50:15 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: tim@cyberelk.net, linux-parport@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] paride: remove parport #ifdef's
Message-ID: <20061201225015.2496dd98@localhost.localdomain>
In-Reply-To: <20061201223315.GJ11084@stusta.de>
References: <20061201223315.GJ11084@stusta.de>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2006 23:33:15 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> CONFIG_PARIDE depends on CONFIG_PARPORT_PC, so there's no reason for 
> these #ifdef's.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Alan Cox <alan@redhat.com>
