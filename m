Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbVE3UEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVE3UEJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 16:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVE3UEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 16:04:09 -0400
Received: from oldconomy.demon.nl ([212.238.217.56]:33469 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S261731AbVE3UEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 16:04:06 -0400
Subject: Re: Playing with SATA NCQ
From: Erik Slagter <erik@slagter.name>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Michael Thonke <iogl64nx@gmail.com>, Mark Lord <liml@rtr.ca>
In-Reply-To: <429B6060.1010806@pobox.com>
References: <20050526140058.GR1419@suse.de>
	 <1117382598.4851.3.camel@localhost.localdomain>
	 <4299F47B.5020603@gmail.com>
	 <1117387591.4851.17.camel@localhost.localdomain> <429A58F4.3040308@rtr.ca>
	 <1117438192.4851.29.camel@localhost.localdomain> <429B56CA.5080803@rtr.ca>
	 <1117477364.3108.2.camel@localhost.localdomain>
	 <429B6060.1010806@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 30 May 2005 22:03:40 +0200
Message-Id: <1117483420.3108.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-30 at 14:50 -0400, Jeff Garzik wrote:
> Erik Slagter wrote:
> > I must have been fooled by the FC3 setup disk that handed it libata,  I
> > didn't know libata also handles pata, then.
> 
> libata software supports PATA, but no distribution ships with libata 
> PATA support enabled (nor should they!).

In that case FC3 is not a distribution?!

> There are a few unusual cases with combined mode where libata will 
> support PATA, but those are rare.

ich6/piix :-)
