Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbTFCSLO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 14:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbTFCSLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 14:11:14 -0400
Received: from router.emperor-sw2.exsbs.net ([208.254.201.37]:46254 "EHLO
	sade.emperorlinux.com") by vger.kernel.org with ESMTP
	id S261706AbTFCSLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 14:11:13 -0400
From: Josh Litherland <fauxpas@sade.emperorlinux.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux and IBM : "unauthorized" mini-PCI : TCPA updates
In-Reply-To: <1054658054.9359.49.camel@dhcp22.swansea.linux.org.uk>
X-Newsgroups: mlist.linux-kernel
User-Agent: tin/1.5.17-20030301 ("Bubbles") (UNIX) (Linux/2.4.21-pre5-ac3 (i686))
Message-Id: <20030603182937.BBFF86207B@sade.emperorlinux.com>
Date: Tue,  3 Jun 2003 14:29:37 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1054658054.9359.49.camel@dhcp22.swansea.linux.org.uk> you wrote:

> Secondly TCPA doesn't require such a restriction. A TCPA system can have
> hardware whitelists so that the TCPA chip refuses to do any TCPA with
> unknown devices present (since they may be hostile) but it doesn't have
> to fail to boot in this case.

Interestingly, when the offending device is a modem, it will warn in
the BIOS but will neither disable the device nor refuse to boot.  Only
when a wireless NIC is inserted will it grind to a bloody halt.

-- 
Josh Litherland (josh@emperorlinux.com)
