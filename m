Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbWBMXAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbWBMXAk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030243AbWBMXAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:00:39 -0500
Received: from gold.veritas.com ([143.127.12.110]:39276 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1030254AbWBMXAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:00:36 -0500
Date: Mon, 13 Feb 2006 23:01:20 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
cc: Linus Torvalds <torvalds@osdl.org>, William Irwin <wli@holomorphy.com>,
       Roland Dreier <rdreier@cisco.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: Re: madvise MADV_DONTFORK/MADV_DOFORK
In-Reply-To: <20060213225538.GE13603@mellanox.co.il>
Message-ID: <Pine.LNX.4.61.0602132259450.4627@goblin.wat.veritas.com>
References: <20060213154114.GO32041@mellanox.co.il> <Pine.LNX.4.64.0602131104460.3691@g5.osdl.org>
 <adar767133j.fsf@cisco.com> <Pine.LNX.4.64.0602131125180.3691@g5.osdl.org>
 <Pine.LNX.4.61.0602131943050.9573@goblin.wat.veritas.com>
 <20060213210906.GC13603@mellanox.co.il> <Pine.LNX.4.61.0602132157110.3761@goblin.wat.veritas.com>
 <Pine.LNX.4.64.0602131426470.3691@g5.osdl.org> <20060213225538.GE13603@mellanox.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Feb 2006 23:00:35.0379 (UTC) FILETIME=[4C684030:01C630F1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2006, Michael S. Tsirkin wrote:
> Here's the final version then.

Acked-by: Hugh Dickins <hugh@veritas.com>
