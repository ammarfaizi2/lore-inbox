Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbTIVI5y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 04:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbTIVI5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 04:57:54 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:14098 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S262336AbTIVI5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 04:57:53 -0400
Date: Mon, 22 Sep 2003 06:00:32 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
X-X-Sender: marcelo@logos.cnet
To: linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: HT not working by default since 2.4.22
Message-ID: <Pine.LNX.4.44.0309220551140.32694-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Ive received a few complaints that HT, starting from 2.4.22, needs ACPI
enabled. Users who had HT working now have to use ACPI and they didnt
before.

We should have HT working AUTOMATICALLY without ACPI enabled and WITHOUT
any special boot option, as before.

Please lets fix that up

Len?



