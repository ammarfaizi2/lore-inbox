Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270444AbTGSAXP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 20:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270447AbTGSAXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 20:23:15 -0400
Received: from ip67-95-245-82.z245-95-67.customer.algx.net ([67.95.245.82]:40967
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S270444AbTGSAXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 20:23:14 -0400
Date: Fri, 18 Jul 2003 17:38:24 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre7
Message-ID: <20030719003824.GI2289@matchmail.com>
Mail-Followup-To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0307181649290.29493@freak.distro.conectiva> <1058569601.544.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058569601.544.1.camel@teapot.felipe-alfaro.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 19, 2003 at 01:06:41AM +0200, Felipe Alfaro Solana wrote:
> On Fri, 2003-07-18 at 21:53, Marcelo Tosatti wrote:
> > Hello,
> > 
> > Here goes -pre7.
> 
> Will ACL/xattr support get its way onto mainstream 2.4 soon?

Doubt it.

Unless it gets into -ac or -aa for a long while and a whole bunch of users
clamor for it.

So, is acl only working with ext[23] & XFS?  What about reiserfs or jfs?

I was thinking of giving the acl patch a try one of these days.  There are a
couple things where the ugo model doesn't work at my company.

Mike
