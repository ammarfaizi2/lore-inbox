Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271338AbTGQQwM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 12:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271504AbTGQQwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 12:52:12 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:1543 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271338AbTGQQwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 12:52:09 -0400
Date: Thu, 17 Jul 2003 18:06:58 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Jacek =?iso-8859-2?Q?Pop=B3awski?= <jp@angry-pixels.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: radeonfb and 32bit depth
In-Reply-To: <1058350410.515.45.camel@gaston>
Message-ID: <Pine.LNX.4.44.0307171806210.10255-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Tue, 2003-07-15 at 08:00, Jacek Pop³awski wrote:
> > I was testing radeonfb in 2.4.22-pre6, my card is Sapphire 9100.

> > cursor changes to black.
> 
> That's a known problem with fbdev core, the "fix" would be to
> implement HW cursor support in radeonfb...

Cursor problem in 2.4.22-pre6 ?? I guess 2.5.X fbdev is in the same shape 
as 2.4.X

