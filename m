Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268121AbUHTO6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268121AbUHTO6X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 10:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266334AbUHTO6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 10:58:23 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:16000 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S268121AbUHTO4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 10:56:41 -0400
Date: Fri, 20 Aug 2004 15:56:02 +0100
From: Dave Jones <davej@redhat.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jeremy@goop.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@codemonkey.org.uk>
Subject: Re: [PATCH] dothan speedstep fix
Message-ID: <20040820145602.GL4148@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Con Kolivas <kernel@kolivas.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, jeremy@goop.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Dave Jones <davej@codemonkey.org.uk>
References: <4125A036.8020401@kolivas.org> <1093009108.30968.43.camel@localhost.localdomain> <41260FE7.4070407@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41260FE7.4070407@kolivas.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2004 at 12:51:19AM +1000, Con Kolivas wrote:
 > Alan Cox wrote:
 > >On Gwe, 2004-08-20 at 07:54, Con Kolivas wrote:
 > >
 > >>Hi Jeremy
 > >>
 > >>My new dothan cpu comes up as stepping 6. This patch fixes speedstep 
 > >>support for my laptop unless it can come up as multiple stepping values? 
 > >>Now all I need is for a way to make it report the correct L2 cache.
 > >
 > >
 > >The patch I posted to l/k a few minutea ago should fix the L2 cache
 > >reporting. 
 > 
 > Looks like you preempted DaveJ by a handful of emails.
 > 
 > Both patches look good (especially since they're identical ;))

Not quite 8-)  Alan's missed off 0x7f

		Dave

