Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264286AbUFNXQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbUFNXQH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 19:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264585AbUFNXQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 19:16:06 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:722 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264286AbUFNXO2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 19:14:28 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Adolfo =?iso-8859-15?q?Gonz=E1lez=20Bl=E1zquez?= 
	<agblazquez_mailing@telefonica.net>
Subject: Re: pdc202xx_old serious bug with DMA on 2.6.x series
Date: Tue, 15 Jun 2004 01:18:33 +0200
User-Agent: KMail/1.5.3
References: <1087253451.4817.4.camel@localhost>
In-Reply-To: <1087253451.4817.4.camel@localhost>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200406150118.34034.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 of June 2004 00:50, Adolfo González Blázquez wrote:
> Hi!

Hi,

> Lot of users are reporting seriour problems with pdc202xx_old ide pci
> driver. Enabling DMA on any device related with this driver makes the
> system unusable.
>
> This seems to happen in all the 2.6.x kernel series.

Doing binary search on 2.4->2.6 kernels would help greatly
(narrowing problem to a specific kernel versions).

> More info on Kerneltrap: http://kerneltrap.org/node/view/3040
> More info on Bugzilla: http://bugzilla.kernel.org/show_bug.cgi?id=2494
>
> I hope someone can fix this, 'cause there's a lot of people using these
> ide controllers.

It seems everybody wants it fixed but nobody is willing to help...

> Adolfo González

