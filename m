Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262958AbVAFS7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262958AbVAFS7Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 13:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262982AbVAFS7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 13:59:00 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:55227 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262970AbVAFSzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 13:55:54 -0500
Subject: Re: ARP routing issue
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan De Luyck <lkml@kcore.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
In-Reply-To: <200501061647.45226.lkml@kcore.org>
References: <200501061647.45226.lkml@kcore.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105029639.24187.225.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 06 Jan 2005 17:51:43 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-01-06 at 15:47, Jan De Luyck wrote:
> Problem is, if I try to ping from another network (10.216.0.xx) to 10.0.24.xx, 
> i see the following ARP request:
> 
> arp who-has 10.0.22.1 tell 10.0.24.xx
> 
> which, imo, is wrong.

With the info you've given it could be right or wrong. Can you provide a
mini plumbing diagram to go with it. Who is arping for what too ?

