Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbVJFTKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbVJFTKm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 15:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbVJFTKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 15:10:42 -0400
Received: from mail.kroah.org ([69.55.234.183]:29404 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751312AbVJFTKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 15:10:41 -0400
Date: Thu, 6 Oct 2005 12:09:42 -0700
From: Greg KH <greg@kroah.com>
To: Mark Underwood <basicmark@yahoo.com>, David Brownell <david-b@pacbell.net>,
       vwool@ru.mvista.com, stephen@streetfiresound.com,
       spi-devel-general@lists.sourceforge.net, pavel@ucw.cz,
       linux-kernel@vger.kernel.org, dpervushin@gmail.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Get rid of the obsolete tri-level suspend/resume callbacks (was: Re: [PATCH/RFC 1/2] simple SPI framework)
Message-ID: <20051006190941.GA15274@kroah.com>
References: <20051005143946.7D9C9EE8EC@adsl-69-107-32-110.dsl.pltn13.pacbell.net> <20051006182349.7430.qmail@web33007.mail.mud.yahoo.com> <20051006182938.GA5312@flint.arm.linux.org.uk> <20051006190234.GB5312@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051006190234.GB5312@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2005 at 08:02:34PM +0100, Russell King wrote:
> 
> Since this is obsolete infrastructure which is no longer necessary,
> we can remove it.  Here's an (untested) patch to do exactly that.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

