Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262618AbULPBZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262618AbULPBZS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 20:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbULPBVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 20:21:34 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:41089 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262557AbULPBKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 20:10:47 -0500
Subject: Re: arch/xen is a bad idea
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>, Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       Steven.Hand@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk,
       Keir.Fraser@cl.cam.ac.uk
In-Reply-To: <20041215044927.GF27225@wotan.suse.de>
References: <p73acsg1za1.fsf@bragg.suse.de>
	 <E1CeLLB-0000Sl-00@mta1.cl.cam.ac.uk>
	 <20041215044927.GF27225@wotan.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103155782.3585.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 16 Dec 2004 00:09:44 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-12-15 at 04:49, Andi Kleen wrote:
> I think that's definitely the wrong way. Also in Linux 
> the standard strategy is to first clean up and restructure/refactor 
> code and then merge, not the other way round.

Must be two different Linux OS's out there then. I thought it was
- get interfaces right
- get working
- get correct
- merge
- evolve

If we did it as you describe we'd still not have a SATA layer merged for
example.
