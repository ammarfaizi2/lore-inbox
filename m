Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbUCHP1G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 10:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbUCHP1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 10:27:06 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:23235 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262497AbUCHP06
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 10:26:58 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: covici@ccs.covici.com
Subject: Re: shuttle an50r Motherboard and Linux
Date: Mon, 8 Mar 2004 16:33:38 +0100
User-Agent: KMail/1.5.3
Cc: John Covici <covici@ccs.covici.com>, linux-kernel@vger.kernel.org
References: <m3wu5w8aex.fsf@ccs.covici.com> <200403080151.28816.bzolnier@elka.pw.edu.pl> <16460.36222.191866.759421@ccs.covici.com>
In-Reply-To: <16460.36222.191866.759421@ccs.covici.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403081633.38437.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 of March 2004 16:13, John covici wrote:
> OK, here are the relevant parts of the lspci -v -- I have been using

IDE interface is missed.

> 2.4.22, but if it will make a difference I will try newer ones.

2.4.x needs update of amd74xx.c driver.  2.6.x should be okay.

Bartlomiej

