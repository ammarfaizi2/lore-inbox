Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbUJ3Vpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbUJ3Vpg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 17:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbUJ3VpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 17:45:10 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:8083 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261339AbUJ3Vma
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 17:42:30 -0400
Date: Sun, 31 Oct 2004 01:43:18 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.9-bk7] Select cpio_list or source directory for initramfs image updates [u]
Message-ID: <20041030234318.GI9592@mars.ravnborg.org>
Mail-Followup-To: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>,
	Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
	torvalds@osdl.org,
	Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
References: <200410200849.i9K8n5921516@mail.osdl.org> <1098533188.668.9.camel@nosferatu.lan> <20041026221216.GA30918@mars.ravnborg.org> <1098824849.12420.60.camel@nosferatu.lan> <20041026231514.GA3285@mars.ravnborg.org> <1098902645.12420.75.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098902645.12420.75.camel@nosferatu.lan>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 08:44:05PM +0200, Martin Schlemmer [c] wrote:
> > 
> 
> How about below?  Works as expected.  I am open to suggestions short of
> coding a util to print numeric mtimes besides find, but for the life of
> me could not think of another way ...

Looks good.
Please send me a version that is not whitespace damaged and with a
proper changelog.
The changelog shall be descriptive in itself without relying on context
from privious patch or comments in a mail.

	Sam
