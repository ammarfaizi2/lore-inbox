Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272841AbTHKRXn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 13:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272827AbTHKRVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 13:21:17 -0400
Received: from magic-mail.adaptec.com ([208.236.45.100]:63419 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S272915AbTHKRUn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 13:20:43 -0400
Date: Mon, 11 Aug 2003 11:22:22 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Paul Blazejowski <paulb@blazebox.homeip.net>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: Linux [2.6.0-test3/mm1] aic7xxx problems.
Message-ID: <2425882704.1060622541@aslan.btc.adaptec.com>
In-Reply-To: <1060543928.887.19.camel@blaze.homeip.net>
References: <1060543928.887.19.camel@blaze.homeip.net>
X-Mailer: Mulberry/3.1.0b5 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On a side note, the same aic7xxx drivers version 6.2.8 and 6.2.36 works
> with 2.4.21 and 2.4.22-rc1/rc2 series of kernel with above hardware.

I don't think that any of the changes between 6.2.35 and 6.2.36 will
make a difference for you, but you could try upgrading.  The source
files are here:

http://people.FreeBSD.org/~gibbs/linux/SRC/

The console output you've provided makes me think that interrupts are
not working correctly in your system.

--
Justin

