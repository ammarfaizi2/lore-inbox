Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbVHIJzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbVHIJzW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 05:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbVHIJzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 05:55:22 -0400
Received: from extgw-uk.mips.com ([62.254.210.129]:25873 "EHLO
	bacchus.net.dhis.org") by vger.kernel.org with ESMTP
	id S932496AbVHIJzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 05:55:21 -0400
Date: Tue, 9 Aug 2005 10:54:19 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       linville@redhat.com
Subject: Re: pci_update_resource() getting called on sparc64
Message-ID: <20050809095418.GA3511@linux-mips.org>
References: <20050808.071211.74753610.davem@davemloft.net> <20050808144439.GA6478@kroah.com> <20050808.103304.55507512.davem@davemloft.net> <Pine.LNX.4.58.0508081131540.3258@g5.osdl.org> <20050808160846.GA7710@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050808160846.GA7710@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 09:08:46AM -0700, Greg KH wrote:

> {sigh}  I only pushed that one as Ralf insisted that he needed it for
> some of his hardware and that there wasn't any bad side-affects.  Ralf,
> any objections to removing this for 2.6.13?

Hmm...  I didn't see any potencial side effects.  If it causes trouble,
away with it.  The currently only affected card that I know of is the
3com 3c556B mini-PCI card.

  Ralf
