Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269107AbUJKPcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269107AbUJKPcL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 11:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269111AbUJKP3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 11:29:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:18593 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268980AbUJKPZc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 11:25:32 -0400
Date: Mon, 11 Oct 2004 08:25:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>
Subject: Re: Linux 2.6.9-rc4 - pls test (and no more patches)
In-Reply-To: <Pine.LNX.4.58.0410110802590.3897@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0410110822170.3897@ppc970.osdl.org>
References: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org>
 <416A5857.1090307@yahoo.com.au> <Pine.LNX.4.58.0410110802590.3897@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Oct 2004, Linus Torvalds wrote:
> 
> That said, your patch is small and simple, so..

Btw, out of interest, make it print out the "package->type" for the 
failure case. It should be ACPI_TYPE_PACKAGE (4), I think, but..

		Linus
