Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266566AbUHINYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266566AbUHINYU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 09:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266565AbUHINYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 09:24:20 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:56970 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S266566AbUHINYO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 09:24:14 -0400
Subject: Re: 2.6.8-rc2-mm1: bluetooth broken?
From: Marcel Holtmann <marcel@holtmann.org>
To: Stephane Jourdois <stephane@rubis.org>
Cc: Filip Van Raemdonck <filipvr@xs4all.be>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040809120705.GA23073@diamant.rubis.org>
References: <20040808191912.GA620@elf.ucw.cz>
	 <1092003277.2773.45.camel@pegasus> <20040809095425.GA12667@debian>
	 <1092046959.21815.15.camel@pegasus>
	 <20040809120705.GA23073@diamant.rubis.org>
Content-Type: text/plain
Message-Id: <1092057843.21815.21.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 09 Aug 2004 15:24:03 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephane,

> > this is what I was thinking, because I always run the latest stuff from
> > the Bitkeeper repository directly. Seems that there is something in the
> > -mm patches that broke it. Can someone test the latest -mm and report if
> > the Bluetooth subsystem is working or not?
> 
> Not working here since 2.6.8-rc2-mm2.
> Works in 2.6.8-rc2-mm1.

I never used a -mm patch, so you must be a little bit more specific what
is not working. What Bluetooth hardware are you using? Do the logfiles
or dmesg include anything helpful?

Regards

Marcel


