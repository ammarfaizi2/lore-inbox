Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbUCPTcA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 14:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbUCPTaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 14:30:39 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7950 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261530AbUCPTaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 14:30:20 -0500
Date: Tue, 16 Mar 2004 19:30:14 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: TLD.rmk.(none) junk in BitKeeper logs where BK_HOST belongs?
Message-ID: <20040316193014.B7886@flint.arm.linux.org.uk>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040316184455.GA31710@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040316184455.GA31710@merlin.emma.line.org>; from matthias.andree@gmx.de on Tue, Mar 16, 2004 at 07:44:56PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 07:44:56PM +0100, Matthias Andree wrote:
> whose broken script or BitKeeper installation causes all these annoying
> de.rmk.(none), au.rmk.(none) and all that to be logged instead of the
> real BK_HOST?

I do it purposely.  Go read:

 http://www.informationcommissioner.gov.uk/

and read through the (flash) bits.  Now consider "are email addresses
information which can be used to identify individuals?"  The answer is
"yes".  Are we storing that in a kind of database?  Yes.  Therefore,
does this fall under the terms of the Data Protection Act?  Yes.

Therefore I myself do not want to store peoples email addresses BK,
thereby avoiding this issue entirely.

> I don't care to know who it is but would the offending system please be
> updated or fixed?

Nope - live with it.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
