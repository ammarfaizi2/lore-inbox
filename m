Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbUA0LWX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 06:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263486AbUA0LWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 06:22:23 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:46731 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263435AbUA0LWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 06:22:22 -0500
Date: Tue, 27 Jan 2004 12:22:20 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc in BK: Oops loading parport_pc.
Message-ID: <20040127112219.GC7322@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040125115129.GA10387@merlin.emma.line.org> <20040125151454.70b5011e.akpm@osdl.org> <20040126010832.GA5462@merlin.emma.line.org> <20040126193117.GB7280@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040126193117.GB7280@neo.rr.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jan 2004, Adam Belay wrote:

> Are you using any modules other than parport_pc?  Have you unloaded them
> before loading parport_pc?

Plenty I have, and no, I haven't tried unloading (or, for that matter,
preferably not loading them in the first place) them. Will take a while
before I can test again, I don't have PNP requirements at the moment,
even my USB configuration is static.

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
