Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265262AbSKNWOI>; Thu, 14 Nov 2002 17:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265321AbSKNWH7>; Thu, 14 Nov 2002 17:07:59 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:18584 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S261613AbSKNWHy>;
	Thu, 14 Nov 2002 17:07:54 -0500
Date: Thu, 14 Nov 2002 21:06:42 +0000
From: Benjamin LaHaise <bcrl@redhat.com>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] remove hugetlb syscalls
Message-ID: <20021114210642.GD28216@skynet.ie>
References: <20021113184555.B10889@redhat.com> <20021114203035.GF22031@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021114203035.GF22031@holomorphy.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 12:30:35PM -0800, William Lee Irwin III wrote:
> The main reason I haven't considered doing this is because they already
> got in and there appears to be a user (Oracle/IA64).

Not in shipping code.  Certainly no vendor kernels that I am aware of 
have shipped these syscalls yet either, as nearly all of the developers 
find them revolting.  Not to mention that the code cleanups and bugfixes 
are still ongoing.

		-ben
--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/
