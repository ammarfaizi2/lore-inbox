Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030320AbWHUPyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbWHUPyd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 11:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWHUPyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 11:54:33 -0400
Received: from mail.fieldses.org ([66.93.2.214]:1497 "EHLO pickle.fieldses.org")
	by vger.kernel.org with ESMTP id S932084AbWHUPyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 11:54:33 -0400
Date: Mon, 21 Aug 2006 11:54:31 -0400
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
Message-ID: <20060821155431.GA3678@fieldses.org>
References: <20060820013121.GA18401@fieldses.org> <200608201026.54530.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608201026.54530.ak@suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 10:26:54AM +0200, Andi Kleen wrote:
> 
> > DWARF2 unwinder stuck at 0xc0100199
> > Leftover inexact backtrace:
> >  =======================
> >  BUG: unable to handle kernel paging request at virtual address 0000b034
> 
> This is already fixed in mainline.

I'm seeing the same behavior on Linus's latest as of this morning
(2.6.18-rc4-gef7d1b24).  Is there something else I should be testing?

--b.
