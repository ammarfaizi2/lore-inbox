Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266161AbUAGKRM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 05:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266171AbUAGKRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 05:17:11 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:58785 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S266161AbUAGKRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 05:17:08 -0500
Subject: Re: LVM 2.6 compatibility?
From: Christophe Saout <christophe@saout.de>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20040107090952.GO14285@lug-owl.de>
References: <1073397568.29659.178.camel@roy-sin>
	 <Pine.LNX.4.43.0401070941040.23681-100000@cibs9.sns.it>
	 <20040107090952.GO14285@lug-owl.de>
Content-Type: text/plain
Message-Id: <1073470624.18282.2.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 07 Jan 2004 11:17:04 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mi, den 07.01.2004 schrieb Jan-Benedict Glaw um 10:09:

> Erm, not to mention that I've recently been hit by some bug. This is
> with LVM2 userland and LVM1 metadata. I just wanted to create a
> snapshot, but I got

Snapshots are not yet finished. There is experimental support in the
unstable device-mapper development tree. There's also experimental
support for pvmove there, and some new dm targets (multipath and crypt).


