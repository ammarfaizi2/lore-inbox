Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265211AbSKNUlQ>; Thu, 14 Nov 2002 15:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265222AbSKNUlQ>; Thu, 14 Nov 2002 15:41:16 -0500
Received: from to-velocet.redhat.com ([216.138.202.10]:2814 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S265211AbSKNUlQ>; Thu, 14 Nov 2002 15:41:16 -0500
Date: Thu, 14 Nov 2002 15:48:09 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] remove hugetlb syscalls
Message-ID: <20021114154809.D20258@redhat.com>
References: <20021113184555.B10889@redhat.com> <20021114203035.GF22031@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021114203035.GF22031@holomorphy.com>; from wli@holomorphy.com on Thu, Nov 14, 2002 at 12:30:35PM -0800
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
