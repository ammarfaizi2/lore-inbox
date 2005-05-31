Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVEaHtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVEaHtI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 03:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVEaHtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 03:49:07 -0400
Received: from oldconomy.demon.nl ([212.238.217.56]:31424 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S261289AbVEaHtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 03:49:04 -0400
Subject: Re: Playing with SATA NCQ
From: Erik Slagter <erik@slagter.name>
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Michael Thonke <iogl64nx@gmail.com>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <429B9E68.6080205@rtr.ca>
References: <20050526140058.GR1419@suse.de>
	 <1117382598.4851.3.camel@localhost.localdomain>
	 <4299F47B.5020603@gmail.com>
	 <1117387591.4851.17.camel@localhost.localdomain> <429A58F4.3040308@rtr.ca>
	 <1117438192.4851.29.camel@localhost.localdomain> <429B56CA.5080803@rtr.ca>
	 <1117477364.3108.2.camel@localhost.localdomain>
	 <429B6060.1010806@pobox.com>  <429B9E68.6080205@rtr.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 31 May 2005 09:48:09 +0200
Message-Id: <1117525689.3108.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-30 at 19:14 -0400, Mark Lord wrote:
> > libata software supports PATA, but no distribution ships with libata 
> > PATA support enabled (nor should they!).
> 
> (K)Ubuntu does, and it works very well, thanks.

So that's two... Does it also show your (pata) harddisk as /dev/sda?
