Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264274AbUEIGt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264274AbUEIGt2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 02:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264276AbUEIGt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 02:49:28 -0400
Received: from port-212-202-41-96.reverse.qsc.de ([212.202.41.96]:14304 "EHLO
	rocklinux-consulting.de") by vger.kernel.org with ESMTP
	id S264274AbUEIGt0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 02:49:26 -0400
Date: Sun, 09 May 2004 08:49:23 +0200 (CEST)
Message-Id: <20040509.084923.558886277.rene@rocklinux-consulting.de>
To: shemminger@osdl.org, linux-kernel@vger.kernel.org
Cc: rock-user@rocklinux.org
Subject: Re: Distributions vs kernel development
From: Rene Rebe <rene@rocklinux-consulting.de>
In-Reply-To: <409BB334.7080305@pobox.com>
References: <20040507085312.3247d70d@dell_ss3.pdx.osdl.net>
	<409BB334.7080305@pobox.com>
X-Mailer: Mew version 3.1 on XEmacs 21.4.13 (Rational FORTRAN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam detection software, running on the system "heap.localnet", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or block
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, On: Fri, 07 May 2004 12:03:00 -0400, Jeff Garzik
	<jgarzik@pobox.com> wrote: > Stephen Hemminger wrote: > > After having
	being burned twice: first by Mandrake and supermount, and second > > by
	SuSe and reiserfs attributes; are any of the distributions committed to
	> > making sure that their distribution will run the standard kernel?
	(ie. 2.6.X from > > kernel.org). When running a non-vendor kernel, I
	need to reasonably expect that the system > > will boot and all the
	filesystems and standard devices are available. I don't > > expect
	every startup script to run clean, or every device that has a driver >
	> only in the vendor kernel to work. > > Fedora Core runs stock 2.4 and
	2.6 kernels just fine... :) > > Jeff [...] 
	Content analysis details:   (0.0 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On: Fri, 07 May 2004 12:03:00 -0400,
    Jeff Garzik <jgarzik@pobox.com> wrote:
> Stephen Hemminger wrote:
> > After having being burned twice: first by Mandrake and supermount, and second
> > by SuSe and reiserfs attributes; are any of the distributions committed to
> > making sure that their distribution will run the standard kernel? (ie. 2.6.X from
> > kernel.org). When running a non-vendor kernel, I need to reasonably expect that the system
> > will boot and all the filesystems and standard devices are available.  I don't
> > expect every startup script to run clean, or every device that has a driver
> > only in the vendor kernel to work. 
> 
> Fedora Core runs stock 2.4 and 2.6 kernels just fine...   :)
> 
> 	Jeff

Since other use this chance to propose already well known
distributions I just want to add that ROCK Linux is also designed to
run vanilla kernels - and in fact we only patch vitally important
changes (such as compile fixes / header fixes) into the -rock kernel.

  http://www.rocklinux.org

Sincerely yours,
  René Rebe
    - ROCK Linux stable release maintainer

--  
René Rebe - Europe/Germany/Berlin
  rene@rocklinux.org rene@rocklinux-consulting.de
http://www.rocklinux.org http://www.rocklinux-consulting.de

