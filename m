Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbUA0EFP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 23:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbUA0EFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 23:05:15 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:37008 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S261733AbUA0EFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 23:05:11 -0500
Date: Mon, 26 Jan 2004 20:04:46 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Glenn Johnson <glennpj@charter.net>
Cc: Andrew Morton <akpm@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc1-mm1 oops with X
Message-ID: <20040127040446.GA2445@srv-lnx2600.matchmail.com>
Mail-Followup-To: Glenn Johnson <glennpj@charter.net>,
	Andrew Morton <akpm@osdl.org>,
	David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
References: <20040123061927.GA7025@gforce.johnson.home> <20040122231814.149c8e8d.akpm@osdl.org> <1074848612.23073.81.camel@imladris.demon.co.uk> <20040123011158.665ad574.akpm@osdl.org> <1074850572.23073.83.camel@imladris.demon.co.uk> <20040123014453.775a0ba7.akpm@osdl.org> <20040123170504.GA21623@node1.cluster.srrc.usda.gov> <20040123215624.GX23765@srv-lnx2600.matchmail.com> <20040124043326.GB14701@gforce.johnson.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040124043326.GB14701@gforce.johnson.home>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 10:33:27PM -0600, Glenn Johnson wrote:
> On Fri, Jan 23, 2004 at 01:56:24PM -0800, Mike Fedyk wrote:
> > > I can make it happen fairly regularly.  Let me know if there is
> > > something I can do to provide more useful output.
> >
> > How, starting X?
> 
> Yes.
> 
> > How far does it get through, and at what point in X startup does the
> > kernel oops?
> 
> I would say fairly early on but I do not know how to quantify that.

Post your log file, and show where in the log the oops occours...
