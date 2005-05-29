Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVE2R43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVE2R43 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 13:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVE2R43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 13:56:29 -0400
Received: from mail.kroah.org ([69.55.234.183]:59264 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261368AbVE2R41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 13:56:27 -0400
Date: Sun, 29 May 2005 11:03:16 -0700
From: Greg KH <greg@kroah.com>
To: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org, stable@kernel.org
Subject: Re: Linux 2.6.11.11
Message-ID: <20050529180316.GF6797@kroah.com>
References: <20050527160437.GL23013@shell0.pdx.osdl.net> <20050529131734.GC13418@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050529131734.GC13418@merlin.emma.line.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2005 at 03:17:34PM +0200, Matthias Andree wrote:
> On Fri, 27 May 2005, Chris Wright wrote:
> 
> > Ralf B??chle:
> >   o Fix minor security hole
> 
> Please check your character sets.
> 
> This looks as though it was converted from ISO-8859-1 to UTF-8 without
> proper declaration.

Yeah, it's probably my scripts that caused this.  Sorry about that.

greg k-h
