Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263132AbVAFXy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263132AbVAFXy1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 18:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbVAFXyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 18:54:22 -0500
Received: from ozlabs.org ([203.10.76.45]:18893 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263133AbVAFXxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 18:53:20 -0500
Date: Fri, 7 Jan 2005 10:53:00 +1100
From: Anton Blanchard <anton@samba.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andi Kleen <ak@muc.de>, Steve Longerbeam <stevel@mvista.com>,
       Hugh Dickins <hugh@veritas.com>, Ray Bryant <raybry@sgi.com>,
       Christoph Lameter <clameter@sgi.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>,
       Marcello Tosatti <marcelo.tosatti@cyclades.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, andrew morton <akpm@osdl.org>
Subject: Re: page migration patchset
Message-ID: <20050106235300.GC14239@krispykreme.ozlabs.ibm.com>
References: <Pine.LNX.4.44.0501052008160.8705-100000@localhost.localdomain> <41DC7EAD.8010407@mvista.com> <20050106144307.GB59451@muc.de> <20050106223046.GB9636@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106223046.GB9636@holomorphy.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The second is zero bugfixing or cross-architecture testing activity
> apart from my own. This and the first in conjunction cast serious
> doubt upon and increase the need for heavy critical examination of
> so-called ``consolidation'' patches.

OK lets get moving on the bug fixing. I know of one outstanding hugetlb
bug which is the one you have been working on.

Can we have a complete bug report on it so the rest of us can try to assist?

Anton
