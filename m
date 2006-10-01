Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWJAUVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWJAUVe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 16:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWJAUVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 16:21:34 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60832 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932303AbWJAUVd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 16:21:33 -0400
Subject: Re: Question on HDLC and raw access to T1/E1 serial streams.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ben Greear <greearb@candelatech.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <45200BD7.6030509@candelatech.com>
References: <451DC75E.4070403@candelatech.com>
	 <m3mz8hntqu.fsf@defiant.localdomain> <451EE973.10907@candelatech.com>
	 <m3hcyo2qvs.fsf@defiant.localdomain>  <45200BD7.6030509@candelatech.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 01 Oct 2006 21:46:26 +0100
Message-Id: <1159735586.13029.180.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-10-01 am 11:41 -0700, ysgrifennodd Ben Greear:
> At least some out-of-tree drivers seem to be able to do this.  For 
> instance, these guys:
> http://www.farsite.co.uk/


The crazy Zaptel guys can probably do precisely what you need as their
hardware though aimed at voice work lets software get in at an extremely
low level.

