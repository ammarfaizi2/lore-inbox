Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269193AbUJKT3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269193AbUJKT3q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 15:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269198AbUJKT3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 15:29:46 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:34713 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S269193AbUJKT3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 15:29:45 -0400
Subject: Re: Linux 2.6.9-rc4 - pls test (and no more patches)
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andre Tomt <andre@tomt.net>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <416ACF5E.80407@tomt.net>
References: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org>	<416A53D3.9020002@tomt.ne
	t> 	<Pine.LNX.4.58.0410110758500.3897@ppc970.osdl.org>
	<1097507381.2029.40.camel@mulgrave>  <416ACF5E.80407@tomt.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 11 Oct 2004 14:29:27 -0500
Message-Id: <1097522974.2029.161.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-11 at 13:22, Andre Tomt wrote:
> I've been running 2.20.3.1 + the data corruption bug fix on megaraids 
> ranging from low-end SATA adapters to the u320scsi ones for a while on a 
> 2.6.8 based kernel, nothing have blown up yet. The old 2.20.3.1 without 
> the fix have been holding up too though - however having a known data 
> corruption bug lingering doesn't feel so good :-)

Yes, well, that's one of the things that worries me slightly ... no-one
has reported the data corruption that the patch claims to fix.  That's
one of the reasons I was planning to take it through the normal cycle.

James


