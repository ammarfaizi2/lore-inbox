Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUANVpp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 16:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUANVpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 16:45:45 -0500
Received: from pop.gmx.de ([213.165.64.20]:18891 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263775AbUANVpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 16:45:44 -0500
X-Authenticated: #20450766
Date: Wed, 14 Jan 2004 19:16:10 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Pavel Machek <pavel@suse.cz>
cc: Mike Fedyk <mfedyk@matchmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 NFS-server low to 0 performance
In-Reply-To: <20040113003908.GB4752@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0401141915420.15120-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jan 2004, Pavel Machek wrote:

> If TCP sees packets are lost, it says "oh, congestion", and starts
> sending packets   more   slowly   ie       introduces          delays
> between          packets.     When    they   no longer  get lost, it
> speeds up to full speed.

Thanks to all!

Guennadi
---
Guennadi Liakhovetski


