Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbTLWPoG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 10:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbTLWPoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 10:44:05 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:32019 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S261613AbTLWPoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 10:44:03 -0500
Date: Tue, 23 Dec 2003 15:43:25 +0000
From: Joe Thornber <thornber@sistina.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Joe Thornber <thornber@sistina.com>,
       Christophe Saout <christophe@saout.de>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Fruhwirth Clemens <clemens@endorphin.org>
Subject: Re: [PATCH 2/2][RFC] Add dm-crypt target
Message-ID: <20031223154325.GF476@reti>
References: <1072129379.5570.73.camel@leto.cs.pocnet.net> <20031222215236.GB13103@leto.cs.pocnet.net> <20031223131355.A6864@infradead.org> <1072186582.4111.46.camel@leto.cs.pocnet.net> <20031223151545.GE476@reti> <20031223153143.GA28690@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031223153143.GA28690@gtf.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 10:31:43AM -0500, Jeff Garzik wrote:
> I agree w/ Christoph...  overly defensive programming like this just
> creates a new class of programmer errors, doesn't really solve anything.
> It's standard Linux kernel style, and making code look like all other
> code has benefits in review and debugging.  Finally, the programmer
> should be paying attention to what kernel APIs he/she uses, and add
> headers accordingly.

ok, I don't feel strongly enough about it to argue, so we'll change it.

- Joe
