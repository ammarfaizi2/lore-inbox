Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265335AbUAJTHJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 14:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265336AbUAJTHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 14:07:09 -0500
Received: from odpn1.odpn.net ([212.40.96.53]:3986 "EHLO odpn1.odpn.net")
	by vger.kernel.org with ESMTP id S265335AbUAJTHH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 14:07:07 -0500
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       Scott Feldman <scott.feldman@intel.com>
Subject: Re: 2.4.24 eth0: TX underrun, threshold adjusted.
References: <x665fkb59o@gzp> <1073746559.752.44.camel@tux.rsn.bth.se>
	<x6oetb66uu@gzp> <1073757207.752.50.camel@tux.rsn.bth.se>
	<x6d69r65yv@gzp> <1073759038.752.56.camel@tux.rsn.bth.se>
From: "Gabor Z. Papp" <gzp@papp.hu>
Date: Sat, 10 Jan 2004 20:07:02 +0100
Message-ID: <x64qv362sp@gzp>
User-Agent: Gnus/5.1004 (Gnus v5.10.4)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Authenticated: gzp1 odpn1.odpn.net a3085bdc7b32ae4d7418f70f85f7cf5f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Martin Josefsson <gandalf@wlug.westbo.se>:

| From my understanding you need to use an intel server-chipset to get
| good pci-performance, or a serverworks one.
| It seems the old Intel chipsets had quite good pci-performance but the
| newer low to medium-range chipsets just suck. But I might be mistaken,
| won't be the first time :)

Switched from *i815* [Asus TUSL2-C] to *i845G* [Asus P4PE-X].

Both old and new config had 6 PCI and 1 AGP card installed.
(2 VGA, 2 NIC, 1 Sound, 1 ATA and the AGP card)

