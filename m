Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265499AbUGMQtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265499AbUGMQtR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 12:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265509AbUGMQtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 12:49:16 -0400
Received: from havoc.gtf.org ([216.162.42.101]:25760 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S265499AbUGMQtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 12:49:13 -0400
Date: Tue, 13 Jul 2004 12:49:11 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: "Eric D. Mudama" <edmudama@bounceswoosh.org>,
       "Robert M. Stockmann" <stock@stokkie.net>, linux-kernel@vger.kernel.org
Subject: Re: SATA disk device naming ?
Message-ID: <20040713164911.GA947@havoc.gtf.org>
References: <20040713064645.GA1660@bounceswoosh.org> <Pine.GSO.4.33.0407131221000.25702-100000@sweetums.bluetronic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.33.0407131221000.25702-100000@sweetums.bluetronic.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 12:23:32PM -0400, Ricky Beam wrote:
> On Tue, 13 Jul 2004, Eric D. Mudama wrote:
> >... "root=LABEL=/" ...
> 
> I've seen the LABEL method not work at all. (2.6.7-rc3 on the wikipedia
> servers.)

For LABEL to work, your filesystem needs to support it.

For LABEL to work on root filesystem, you need an initrd.

	Jeff



