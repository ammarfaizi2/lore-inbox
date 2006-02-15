Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422906AbWBOGSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422906AbWBOGSQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 01:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422998AbWBOGSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 01:18:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24470 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422906AbWBOGSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 01:18:15 -0500
Date: Tue, 14 Feb 2006 22:16:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: nickpiggin@yahoo.com.au, mst@mellanox.co.il, hugh@veritas.com,
       wli@holomorphy.com, gleb@minantech.com, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       vandrove@vc.cvut.cz, pbadari@us.ibm.com, grundler@parisc-linux.org,
       matthew@wil.cx
Subject: Re: [PATCH] madvise MADV_DONTFORK/MADV_DOFORK
Message-Id: <20060214221654.67288424.akpm@osdl.org>
In-Reply-To: <adawtfxqhk1.fsf@cisco.com>
References: <20060213154114.GO32041@mellanox.co.il>
	<Pine.LNX.4.64.0602131104460.3691@g5.osdl.org>
	<adar767133j.fsf@cisco.com>
	<Pine.LNX.4.64.0602131125180.3691@g5.osdl.org>
	<Pine.LNX.4.61.0602131943050.9573@goblin.wat.veritas.com>
	<20060213210906.GC13603@mellanox.co.il>
	<Pine.LNX.4.61.0602132157110.3761@goblin.wat.veritas.com>
	<Pine.LNX.4.64.0602131426470.3691@g5.osdl.org>
	<20060213225538.GE13603@mellanox.co.il>
	<Pine.LNX.4.61.0602132259450.4627@goblin.wat.veritas.com>
	<20060213233517.GG13603@mellanox.co.il>
	<43F2AEAE.5010700@yahoo.com.au>
	<adawtfxqhk1.fsf@cisco.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <rdreier@cisco.com> wrote:
>
> Do we still have a chance to change this?

yes, please do.
