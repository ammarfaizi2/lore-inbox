Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWHQBuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWHQBuc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 21:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWHQBuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 21:50:32 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:56214 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932370AbWHQBub
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 21:50:31 -0400
Subject: Re: [RFC][PATCH] Unify interface to persistent CMOS/RTC/whatever
	clock
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: takata@linux-m32r.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       davem@davemloft.net, wli@holomorphy.com,
       Joel Becker <Joel.Becker@oracle.com>
In-Reply-To: <1155768332.6785.58.camel@localhost.localdomain>
References: <1155768332.6785.58.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 16 Aug 2006 18:49:50 -0700
Message-Id: <1155779390.22876.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-16 at 15:45 -0700, john stultz wrote:
> My first pass at this can be found below. There are a few arches
> (specifically: m32r, s390, sparc, sparc64) where I just didn't know what
> to do, or where I suspect I didn't get it right, so I've CC'ed those
> maintainers for suggestions.

Just realized I skipped the ARM arches. I'll get that fixed (or atleast
make an attempt at it) before the next release.

thanks
-john

