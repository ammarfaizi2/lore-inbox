Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032349AbWLGQDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032349AbWLGQDV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 11:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032351AbWLGQDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 11:03:21 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:45939 "EHLO
	mtagate3.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032349AbWLGQDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 11:03:20 -0500
Date: Thu, 7 Dec 2006 18:03:17 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Olivier Galibert <galibert@pobox.com>
Cc: Andi Kleen <ak@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
       "Hack inc." <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/5] PCI MMConfig: Share what's shareable.
Message-ID: <20061207160317.GL28515@rhun.haifa.ibm.com>
References: <20061207144952.GA45089@dspnet.fr.eu.org> <20061207150023.GH28515@rhun.haifa.ibm.com> <20061207151941.GA45592@dspnet.fr.eu.org> <20061207153506.GJ28515@rhun.haifa.ibm.com> <20061207155336.GA50797@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061207155336.GA50797@dspnet.fr.eu.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2006 at 04:53:36PM +0100, Olivier Galibert wrote:

> # git grep '//' -- '*.c' |fgrep -v 'http://' |wc -l
> 14333
> 
> You lost that war ages ago.  Come join us in this millenia,
> line-comments exist officially in C since 1999, and were supported
> way before that.

If I was bored, I might've counted how many /* */ style comments we
had in the source, then used it to construct an elaborate argument why
C++-style comments are evil and Conformance is Goodness, but I'm not,
so I won't.

Cheers,
Muli
