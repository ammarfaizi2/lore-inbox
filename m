Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271696AbTHRMWQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 08:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271699AbTHRMWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 08:22:16 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:31296 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S271696AbTHRMWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 08:22:13 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200308181222.h7ICM7j02449@devserv.devel.redhat.com>
Subject: Re: Linux 2.4.22-rc2-ac3
To: ml@basmevissen.nl (Bas Mevissen)
Date: Mon, 18 Aug 2003 08:22:07 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3F40A202.60701@basmevissen.nl> from "Bas Mevissen" at Aws 18, 2003 11:53:06 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1) Can you supply (automatically created) incremental patches? It saves 
> a lot of time to just be able to apply the increments in a (manually) 
> patched up tree. Furthermore, it saves download time as it is a huge 
> patch (POTS modem...).

Someone was doing it, but I've got other things to do than make incrementals

> 2) What about the new scheduler? Is that a candidate for 2.4.23 (or even 
> 2.4.22)? I'm asking this because I'm playing around with swsusp patches 
> (created for 2.4.21) and the new scheduler in -ac breaks a few things 
> there. If is is a candidate for 2.4.xx real soon, then we need to fix 
> it. Otherwise, it can be postponed.

It works nicely but it does upset a few apps. You'd have to ask Marcelo
but I certainly had no plan to push it to him
