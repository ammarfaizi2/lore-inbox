Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263269AbTKZNZL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 08:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263537AbTKZNZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 08:25:11 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:22022 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263269AbTKZNZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 08:25:06 -0500
Date: Wed, 26 Nov 2003 13:25:05 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test10-mm1
Message-ID: <20031126132505.C5477@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20031125211518.6f656d73.akpm@osdl.org> <20031126085123.A1952@infradead.org> <20031126044251.3b8309c1.akpm@osdl.org> <20031126130936.A5275@infradead.org> <20031126052900.17542bb3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031126052900.17542bb3.akpm@osdl.org>; from akpm@osdl.org on Wed, Nov 26, 2003 at 05:29:00AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 26, 2003 at 05:29:00AM -0800, Andrew Morton wrote:
> But I do not think that making a single kernel symbol inaccessible is an
> appropriate way of resolving a GPFS licensing dispute.

well, GFPS is a derived work with or without it.  It's just that I remember
we had that agreement about merging it only with the _GPL export.  In fact
I'm pretty sure Paul told something about GPLed distributed filesystems from
IBM in that context..

