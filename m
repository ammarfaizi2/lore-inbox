Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267578AbUG3CRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267578AbUG3CRU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 22:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267576AbUG3CRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 22:17:20 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:2712 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S267578AbUG3CRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 22:17:18 -0400
Date: Fri, 30 Jul 2004 04:17:01 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] mlock-as-nonroot revisted
Message-ID: <20040730021701.GC30369@dualathlon.random>
References: <20040729100307.GA23571@devserv.devel.redhat.com> <20040729142829.2a75c9b9.akpm@osdl.org> <Pine.LNX.4.58.0407292050360.9228@dhcp030.home.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0407292050360.9228@dhcp030.home.surriel.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 08:51:27PM -0400, Rik van Riel wrote:
> the mistake Andrea identified, but that code's been
> fixed too now...

I'm afraid not.
