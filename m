Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269471AbUJLGA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269471AbUJLGA3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 02:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269472AbUJLGA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 02:00:29 -0400
Received: from puzzle.sasl.smtp.pobox.com ([207.8.226.4]:21174 "EHLO
	sasl.smtp.pobox.com") by vger.kernel.org with ESMTP id S269471AbUJLGA1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 02:00:27 -0400
Date: Mon, 11 Oct 2004 23:00:23 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Brown, Len" <len.brown@intel.com>
Subject: Re: Linux 2.6.9-rc4 - pls test (and no more patches)
Message-ID: <20041012060023.GA9196@ip68-4-98-123.oc.oc.cox.net>
References: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org> <416A5857.1090307@yahoo.com.au> <Pine.LNX.4.58.0410110802590.3897@ppc970.osdl.org> <416B1BB8.7020401@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416B1BB8.7020401@yahoo.com.au>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 09:48:08AM +1000, Nick Piggin wrote:
> OK you've merged it... well thanks. I guess considering I'm the only
> one seeing this, it isn't going to impact anyone but me. Probably
> avoiding an oops is a good thing even if it is due to broken hardware.

FWIW I think at one point I saw this oops, or a similar one -- but I
just didn't bother reporting it. So, I'm glad that this check has been
added.

-Barry K. Nathan <barryn@pobox.com>

