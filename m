Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbVAGAij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbVAGAij (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 19:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVAGAen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 19:34:43 -0500
Received: from colin2.muc.de ([193.149.48.15]:25093 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261210AbVAGAbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 19:31:13 -0500
Date: 7 Jan 2005 01:31:11 +0100
Date: Fri, 7 Jan 2005 01:31:11 +0100
From: Andi Kleen <ak@muc.de>
To: Anton Blanchard <anton@samba.org>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Steve Longerbeam <stevel@mvista.com>, Hugh Dickins <hugh@veritas.com>,
       Ray Bryant <raybry@sgi.com>, Christoph Lameter <clameter@sgi.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>,
       Marcello Tosatti <marcelo.tosatti@cyclades.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, andrew morton <akpm@osdl.org>
Subject: Re: page migration patchset
Message-ID: <20050107003111.GA51656@muc.de>
References: <Pine.LNX.4.44.0501052008160.8705-100000@localhost.localdomain> <41DC7EAD.8010407@mvista.com> <20050106144307.GB59451@muc.de> <20050106223046.GB9636@holomorphy.com> <20050106235300.GC14239@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106235300.GC14239@krispykreme.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can we have a complete bug report on it so the rest of us can try to assist?

The crash bug seems to be x86-64 specific. 

-Andi
