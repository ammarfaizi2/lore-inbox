Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264953AbUF1NxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264953AbUF1NxZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 09:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264961AbUF1NxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 09:53:25 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:11727 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264953AbUF1NxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 09:53:24 -0400
Date: Thu, 24 Jun 2004 21:57:35 +0200
From: Pavel Machek <pavel@suse.cz>
To: Len Brown <len.brown@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrey Panin <pazke@donpac.ru>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] 2.6.7-mm1, remove unused ASUS K7V-RM DMI quirk
Message-ID: <20040624195734.GF698@openzaurus.ucw.cz>
References: <10879946911371@donpac.ru> <40D9996C.3080904@pobox.com> <1088009583.4319.289.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1088009583.4319.289.camel@dhcppc4>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Dead code, go ahead and clean it out.

My fault, thanks for cleaning.

> Indeed, in the upstream kernel, I'm thinking about deleting
> all the ACPI related blacklist entries.
> Maintaining them is more trouble than it is worth.
> When they do work, they generally are masking bugs
> that we should instead fix.

Well, I guess that for 2.6 we want them masked.
For 2.7, proper fix is better...
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

