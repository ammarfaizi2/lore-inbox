Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWIZMZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWIZMZX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 08:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWIZMZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 08:25:23 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39849 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751206AbWIZMZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 08:25:22 -0400
Subject: Re: pata_serverworks oopses in latest -git
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Diego Calleja <diegocg@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060926140016.54d532ba.diegocg@gmail.com>
References: <20060926140016.54d532ba.diegocg@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 26 Sep 2006 13:50:10 +0100
Message-Id: <1159275010.11049.215.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-09-26 am 14:00 +0200, ysgrifennodd Diego Calleja:
> When trying to test the new libata PATA drivers in the latest -git tree, I 
> got this when udev tried to load the module:

Yes something seems to be very ill in the -git tree but I'm not sure
what has changed in the libata core to trigger all this at the moment.

Alan

