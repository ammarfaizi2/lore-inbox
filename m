Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268050AbUHVSKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268050AbUHVSKJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 14:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268055AbUHVSKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 14:10:09 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:57220 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S268050AbUHVSJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 14:09:56 -0400
Date: Sun, 22 Aug 2004 20:09:54 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040822180954.GB27210@merlin.emma.line.org>
Mail-Followup-To: Horst von Brand <vonbrand@inf.utfsm.cl>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <schilling@fokus.fraunhofer.de> <41288E10.nail9MX3BDIPM@burner> <200408221511.i7MFBW2I002954@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408221511.i7MFBW2I002954@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Aug 2004, Horst von Brand wrote:

> In the end, I'd only say that I've been on LKML for a long, long time
> (since it started, more or less). And each single time the head hackers
> agreed on something, and there was a single dissenter, the dissenter was in
> the wrong. Sure, this time could be different, but I have seen absolutely
> no (yes, _no_) evidence here to the contrary.

There _are_ cases where a kernel patch sneaked to a subsystem maintainer
has made it even when some of the "heads" said it was impossible.

The key is convincing a subsystem maintainer that the patch helps and
doesn't hurt. And that doesn't work with a rant and can sometime take a
kernel patch to show how it works.  A decent patch with a more decent
description works wonders - usually.

-- 
Matthias Andree

NOTE YOU WILL NOT RECEIVE MY MAIL IF YOU'RE USING SPF!
Encrypted mail welcome: my GnuPG key ID is 0x052E7D95 (PGP/MIME preferred)
