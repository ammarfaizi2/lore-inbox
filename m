Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263173AbTCWT7a>; Sun, 23 Mar 2003 14:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263175AbTCWT7a>; Sun, 23 Mar 2003 14:59:30 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:51474
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263173AbTCWT70>; Sun, 23 Mar 2003 14:59:26 -0500
Subject: Re: Ptrace hole / Linux 2.2.25
From: Robert Love <rml@tech9.net>
To: Martin Mares <mj@ucw.cz>
Cc: Alan Cox <alan@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Stephan von Krawczynski <skraw@ithnet.com>, Pavel Machek <pavel@ucw.cz>,
       szepe@pinerecords.com, arjanv@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030323195606.GA15904@atrey.karlin.mff.cuni.cz>
References: <20030323193457.GA14750@atrey.karlin.mff.cuni.cz>
	 <200303231938.h2NJcAq14927@devserv.devel.redhat.com>
	 <20030323194423.GC14750@atrey.karlin.mff.cuni.cz>
	 <1048448838.1486.12.camel@phantasy.awol.org>
	 <20030323195606.GA15904@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Organization: 
Message-Id: <1048450211.1486.19.camel@phantasy.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 23 Mar 2003 15:10:12 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-23 at 14:56, Martin Mares wrote:

> But if you assume this, what are the official releases for anyway?

Well, official releases have always been sort of arbitrary for the
kernel... just labeled releases along the course of development. 
Although with the recent addition of the -rc patches, they tend to
ensure the latest round of development at least resulted in a stable
release.  But look at all the major vendors - their 2.4.18 release, for
example, may include whatever the latest pre-patch was at the time.

Anyhow, to answer your question: the official releases are labels along
the course of development for use by vendors, developers, and users who
(as Alan described) can manage their own kernels.

Do not get me wrong, I think users can and should compile their own
kernel if they want.  And as kernel developers, we should facilitate
that.  But if someone requires handholding and instant or controlled
releases of bug fixes, they either need to be able to rely on their own
ability to get them or their vendor.  We have vendors for a reason,
after all.

	Robert Love

