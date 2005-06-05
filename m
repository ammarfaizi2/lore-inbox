Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVFEKMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVFEKMH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 06:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbVFEKMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 06:12:07 -0400
Received: from oldconomy.demon.nl ([212.238.217.56]:30342 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S261353AbVFEKME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 06:12:04 -0400
Subject: Re: Problem with 2.6 kernel and lots of I/O
From: Erik Slagter <erik@slagter.name>
To: Pavel Machek <pavel@ucw.cz>
Cc: Roy Keene <rkeene@psislidell.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050601195922.GA589@openzaurus.ucw.cz>
References: <Pine.LNX.4.62.0505311042470.7546@hammer.psislidell.com>
	 <20050601195922.GA589@openzaurus.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 05 Jun 2005 12:11:02 +0200
Message-Id: <1117966262.5027.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-01 at 21:59 +0200, Pavel Machek wrote:
> > 	Start RAID in degraded mode with remote device (nbd1)
> > 	Hot-add local device (nbd0)
> 
> Stop right here. You may not use nbd over loopback.

Any specific reason (just curious)?
