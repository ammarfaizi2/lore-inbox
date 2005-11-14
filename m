Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbVKNM0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbVKNM0y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 07:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbVKNM0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 07:26:53 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:46815 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751107AbVKNM0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 07:26:53 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Olivier Galibert <galibert@pobox.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051114120417.GA33935@dspnet.fr.eu.org>
References: <20051114021127.GC5735@stusta.de> <4378650A.1070209@drzeus.cx>
	 <1131964282.2821.11.camel@laptopd505.fenrus.org>
	 <20051114111108.GR3699@suse.de>
	 <1131967167.2821.14.camel@laptopd505.fenrus.org>
	 <20051114112402.GT3699@suse.de>
	 <1131967678.2821.21.camel@laptopd505.fenrus.org>
	 <20051114113442.GU3699@suse.de>
	 <1131969212.2821.27.camel@laptopd505.fenrus.org>
	 <20051114120417.GA33935@dspnet.fr.eu.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 14 Nov 2005 12:58:22 +0000
Message-Id: <1131973102.5751.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-11-14 at 13:04 +0100, Olivier Galibert wrote:
> Not theorical for iscsi though.  I guess net+block is a little too
> much.

net + block fits for the simpler stuff at least (nbd, ataoe)

