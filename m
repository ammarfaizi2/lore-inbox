Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270634AbTGNPCt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 11:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270217AbTGNPBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 11:01:19 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:16113 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S270062AbTGNPAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 11:00:12 -0400
Subject: Re: [PATCH] jffs2 super.o for 2.6.0-test1
From: David Woodhouse <dwmw2@infradead.org>
To: Ben Collins <bcollins@debian.org>
Cc: Jamey Hicks <jamey.hicks@hp.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030714151059.GL450@phunnypharm.org>
References: <1058194498.3333.100.camel@vimes.crl.hpl.hp.com>
	 <20030714151059.GL450@phunnypharm.org>
Content-Type: text/plain
Message-Id: <1058195695.27293.12.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.1 (dwmw2) 
Date: Mon, 14 Jul 2003 16:14:56 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-07-14 at 16:10, Ben Collins wrote:
> On Mon, Jul 14, 2003 at 10:54:58AM -0400, Jamey Hicks wrote:
> > 
> > Trivial patch to reenable jffs2 for 2.6.0-test1.
> 
> Seems this might be better, to keep it from being a re-occuring
> problem.

I'm as happy just to ditch all pretence of compatibility in the
Makefile; it isn't a problem for merging because I can just ignore it on
updates or do it by hand on the _rare_ occasion that I add a new file.

I thought I'd already done that, to be honest.

-- 
dwmw2

