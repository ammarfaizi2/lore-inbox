Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbTHSX67 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 19:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbTHSX67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 19:58:59 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:57473 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261545AbTHSX65
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 19:58:57 -0400
Date: Wed, 20 Aug 2003 00:58:24 +0100
From: Jamie Lokier <jamie@shareable.org>
To: John Bradford <john@grabjohn.com>
Cc: aebr@win.tue.nl, macro@ds2.pg.gda.pl, linux-kernel@vger.kernel.org,
       neilb@cse.unsw.edu.au, vojtech@suse.cz
Subject: Re: Input issues - key down with no key up
Message-ID: <20030819235824.GC18035@mail.jlokier.co.uk>
References: <200308191937.h7JJb2M0000234@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308191937.h7JJb2M0000234@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
> Also, the keyboard I'm using requires Set 3 to operate fully, although
> as it's quite possible that I am the only person on the planet who
> uses this model of keyboard with Linux, that might not be a very valid
> argument :-).

It's unfortunate if there are some keyboards that only work properly
in one mode, and others that need the other mode, given that there is
no way to automatically detect which keyboard is which.

If your keyboard requires Set 3 to operate fully, how does it behave
under Windows?  I think it was Andries who said Windows uses translated set 2.

-- Jamie
