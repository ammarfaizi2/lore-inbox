Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263502AbUC3CHX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 21:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263505AbUC3CHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 21:07:23 -0500
Received: from holomorphy.com ([207.189.100.168]:10655 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263502AbUC3CHW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 21:07:22 -0500
Date: Mon, 29 Mar 2004 18:07:00 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Matthew Dobson <colpatch@us.ibm.com>, Paul Jackson <pj@sgi.com>,
       LKML <linux-kernel@vger.kernel.org>, raybry@sgi.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
Message-ID: <20040330020700.GC791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Matthew Dobson <colpatch@us.ibm.com>, Paul Jackson <pj@sgi.com>,
	LKML <linux-kernel@vger.kernel.org>, raybry@sgi.com,
	Andrew Morton <akpm@osdl.org>
References: <20040329041253.5cd281a5.pj@sgi.com> <1080606618.6742.89.camel@arrakis> <20040330012744.GZ791@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040330012744.GZ791@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2004 at 05:27:44PM -0800, William Lee Irwin III wrote:
> ... and all other operations unmodified. In all honesty, the difference
> in overhead and/or implementation complexity between the two invariants
> is miniscule. I don't care who wants what per se; if you want to change
> that invariant, it's not my concern what the invariant is so long as
> it's respected and there's a coherent notion of what people want it to
> be. Given some of your statements, I wonder sometimes if you actually
> understand the "don't care" invariant.

Sorry, that was directed at Paul.


-- wli
