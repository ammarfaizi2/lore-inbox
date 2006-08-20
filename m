Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWHTGpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWHTGpE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 02:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbWHTGpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 02:45:04 -0400
Received: from mail.gmx.de ([213.165.64.20]:38589 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751667AbWHTGpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 02:45:02 -0400
X-Authenticated: #14349625
Subject: Re: And another Oops / BUG? (2.6.17.8 on VIA Epia CL6000)
From: Mike Galbraith <efault@gmx.de>
To: Udo van den Heuvel <udovdh@xs4all.nl>
Cc: linux-kernel@vger.kernel.org, Folkert van Heusden <folkert@vanheusden.com>
In-Reply-To: <44E7369D.2010707@xs4all.nl>
References: <44E29415.4040400@xs4all.nl>
	 <1155713739.6011.30.camel@Homer.simpson.net>  <44E7369D.2010707@xs4all.nl>
Content-Type: text/plain
Date: Sun, 20 Aug 2006 08:53:20 +0000
Message-Id: <1156064000.6690.69.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-08-19 at 18:04 +0200, Udo van den Heuvel wrote:
> Mike Galbraith wrote:
> > Given that you're the only person posting this kind of explosion, I
> > would cast a very skeptical glance toward my hardware.  I'd suggest
> > reverting to a known good kernel first, to verify that you really don't
> > have a hardware problem cropping up.
> 
> How long should I run a 2.6.16.* kernel to be sure enough it is not my
> hardware?

Hard to say.  I'd run it at least twice as long as your longest
explosion free interval.

	-Mike

