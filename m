Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751681AbWHTI32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbWHTI32 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 04:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751675AbWHTI31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 04:29:27 -0400
Received: from ns2.suse.de ([195.135.220.15]:38605 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751680AbWHTI31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 04:29:27 -0400
From: Andi Kleen <ak@suse.de>
To: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
Date: Sun, 20 Aug 2006 10:26:54 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060820013121.GA18401@fieldses.org>
In-Reply-To: <20060820013121.GA18401@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608201026.54530.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> DWARF2 unwinder stuck at 0xc0100199
> Leftover inexact backtrace:
>  =======================
>  BUG: unable to handle kernel paging request at virtual address 0000b034

This is already fixed in mainline.

-Andi
