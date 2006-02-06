Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWBFFIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWBFFIx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 00:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbWBFFIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 00:08:53 -0500
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:59788 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S1750946AbWBFFIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 00:08:52 -0500
Subject: Re: [Fwd: [PATCH 8/12] LED: Add LED device support for ixp4xx
	devices]
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Richard Purdie <rpurdie@rpsys.net>, jbowler@acm.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060205192025.4006a554.akpm@osdl.org>
References: <1139154997.14624.20.camel@localhost.localdomain>
	 <20060205192025.4006a554.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 06 Feb 2006 06:07:34 +0100
Message-Id: <1139202455.3131.56.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-05 at 19:20 -0800, Andrew Morton wrote:
> Richard Purdie <rpurdie@rpsys.net> wrote:
> >
> > +MODULE_AUTHOR("John Bowler <jbowler@acm.org>");
> > +MODULE_DESCRIPTION("IXP4XX GPIO LED driver");
> > +MODULE_LICENSE("MIT");
> 
> MIT license is unusual.  There's one other file in the kernel which uses it
> and that's down in MTD where nobody dares look.
> 
> I don't know whether MIT is GPL-compatible-for-kernel-purposes or not.  Help.

would be really nice if the author would at least dual license it under
the GPL as well (and thus also granting the patent rights if any); in
which case it's a clear "GPL when used with linux, but optionally MIT if
used outside linux")



