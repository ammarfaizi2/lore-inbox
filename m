Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265387AbUF2DzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265387AbUF2DzO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 23:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265390AbUF2DzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 23:55:14 -0400
Received: from host61.200-117-131.telecom.net.ar ([200.117.131.61]:30167 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S265387AbUF2DzK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 23:55:10 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: Re: Just built 2.6.7-mm2, mouse dbl-click needs superfast clicks
Date: Tue, 29 Jun 2004 00:55:04 -0300
User-Agent: KMail/1.6.2
References: <200406282329.08570.gene.heskett@verizon.net>
In-Reply-To: <200406282329.08570.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406290055.04250.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> Greetings;
>
> Running 2.6.7-mm1 elevator=cfq on an athlon 1600-DX

mm1 or mm2?

mm1 had a time-goes-too-fast bug.
mm2 had an acpi thingy that broke usb.
mm3 broke nfs (a one line fix)

... perhaps mm4 will break ide and mm5 will do something to kill ipv{4,6} ... 

Just kiding ;-)

Best regards,
Norberto
