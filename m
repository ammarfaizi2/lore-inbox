Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269505AbUJLIFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269505AbUJLIFr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 04:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269507AbUJLIFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 04:05:46 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:25500 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S269505AbUJLIFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 04:05:42 -0400
Date: Tue, 12 Oct 2004 10:05:37 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc4 - pls test (and no more patches)
Message-ID: <20041012080537.GA6092@merlin.emma.line.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Oct 2004, Linus Torvalds wrote:

>  trying to make ready for the real 2.6.9 in a week or so, so please give
> this a beating, and if you have pending patches, please hold on to them
> for a bit longer, until after the 2.6.9 release. It would be good to have
> a 2.6.9 that doesn't need a dot-release immediately ;)

How about Marcelo's policy that the -final version should differ from
the last -rc only in the Makefile VERSION and nothing else (well,
documentation perhaps if someone else has proofread it).

Would you be ready to have the last -rc out for, say, five days, before
releasing the official, final, blessed, however 2.6.9, in order to catch
the showstoppers?

-- 
Matthias Andree

Encrypted mail welcome: my GnuPG key ID is 0x052E7D95 (PGP/MIME preferred)
