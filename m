Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbVHQDon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbVHQDon (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 23:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbVHQDon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 23:44:43 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:30091 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750822AbVHQDom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 23:44:42 -0400
Subject: Re: [PATCH] [Fwd: Console locking and blanking]
From: Steven Rostedt <rostedt@goodmis.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1124249381.8848.19.camel@gaston>
References: <1124242875.8848.10.camel@gaston>
	 <1124249381.8848.19.camel@gaston>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 16 Aug 2005 23:44:31 -0400
Message-Id: <1124250271.5764.76.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-17 at 13:29 +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2005-08-17 at 11:41 +1000, Benjamin Herrenschmidt wrote:
> 
> > (I'm blind and I use a braille display. I use those functions to blank 
> > my laptop's screen so people don't read it, and hopefully to conserve 
> > power.)

At the OLS I learned that the backlight of a laptop (when the screen is
black, but still glows) actually spends more wattage than when the
screen is lit.  So, unless you actually turn the laptop display off,
switching it to black will actually burn the battery quicker.

-- Steve


