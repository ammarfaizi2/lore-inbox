Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264255AbTKZQYI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 11:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbTKZQYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 11:24:08 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:987 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S264255AbTKZQYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 11:24:06 -0500
Date: Wed, 26 Nov 2003 08:23:52 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test10-mm1
Message-ID: <11470000.1069863830@[10.10.2.4]>
In-Reply-To: <20031126132505.C5477@infradead.org>
References: <20031125211518.6f656d73.akpm@osdl.org> <20031126085123.A1952@infradead.org> <20031126044251.3b8309c1.akpm@osdl.org> <20031126130936.A5275@infradead.org> <20031126052900.17542bb3.akpm@osdl.org> <20031126132505.C5477@infradead.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Nov 26, 2003 at 05:29:00AM -0800, Andrew Morton wrote:
>> But I do not think that making a single kernel symbol inaccessible is an
>> appropriate way of resolving a GPFS licensing dispute.
> 
> well, GFPS is a derived work with or without it.  It's just that I remember
> we had that agreement about merging it only with the _GPL export.  In fact
> I'm pretty sure Paul told something about GPLed distributed filesystems from
> IBM in that context..

IBM has (at the very least) 2 clustered filesystems that use this. One is
GPL'ed, the other (GPFS) is not.

M.

