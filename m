Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbUCPUol (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 15:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbUCPUol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 15:44:41 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:9668 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261637AbUCPUoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 15:44:39 -0500
Date: Tue, 16 Mar 2004 21:44:30 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: TLD.rmk.(none) junk in BitKeeper logs where BK_HOST belongs?
Message-ID: <20040316204430.GB9345@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040316184455.GA31710@merlin.emma.line.org> <20040316191454.GK17813@bitmover.com> <Pine.LNX.4.58.0403161132000.17272@ppc970.osdl.org> <20040316194153.GA15282@merlin.emma.line.org> <20040316194559.D7886@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040316194559.D7886@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2004, Russell King wrote:

> > Two notes:
> > 1.
> > This could be handled by only including patches of those people who
> > consent to their address being published,
> 
> This requires me to keep a database of peoples addresses who have
> consented.  No thanks, that's a huge overhead and waste of time.

"vacation" style recipes for maildrop or procmail do most of the parts
you'd need - sort people's mail into one folder "no-consent", if they
send a patch, ask them for permission, if they consent, drop their mail
address into the DB so their mail is sorted into
"address-export-allowed". Change names as you will.

Just a suggestion to counted the "huge" overhead. It is overhead and
costs time without doubt.

> Have a look in the changesets themselves - you'll find the line "Patch
> from" in them, so you can pick out the real persons name from that -
> even automatically via a suitable regexp.

I'll try.

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
