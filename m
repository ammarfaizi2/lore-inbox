Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVDTBjC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVDTBjC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 21:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVDTBjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 21:39:01 -0400
Received: from holomorphy.com ([66.93.40.71]:43464 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261217AbVDTBiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 21:38:55 -0400
Date: Tue, 19 Apr 2005 18:38:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, akpm@osdl.org, riel@redhat.com, kurt@garloff.de,
       Keir.Fraser@cl.cam.ac.uk, Ian.Pratt@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk
Subject: Re: [PATCH 0/4] io_remap_pfn_range: intro.
Message-ID: <20050420013852.GC2104@holomorphy.com>
References: <20050318112545.6f5f7635.rddunlap@osdl.org> <20050318125617.5e57c3f8.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318125617.5e57c3f8.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2005 11:25:45 -0800 "Randy.Dunlap" <rddunlap@osdl.org> wrote:
>> The sparc32 & sparc64 code needs live testing.

On Fri, Mar 18, 2005 at 12:56:17PM -0800, David S. Miller wrote:
> These patches look great Randy.  I think they should go in.
> If sparc explodes, I'll clean up the mess.  Any problem which
> crops up should not be difficult to solve.

Thanks for covering for me. My understanding of this area of the code
is very limited, so your help is much appreciated here.


-- wli
