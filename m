Return-Path: <linux-kernel-owner+w=401wt.eu-S1761798AbWLJTkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761798AbWLJTkH (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 14:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762403AbWLJTkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 14:40:07 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48640 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761798AbWLJTkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 14:40:05 -0500
Subject: Re: PAE/NX without performance drain?
From: Arjan van de Ven <arjan@infradead.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <457C28F8.4050409@comcast.net>
References: <457B1F02.7030409@comcast.net>
	 <1165743478.27217.187.camel@laptopd505.fenrus.org>
	 <457C28F8.4050409@comcast.net>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 10 Dec 2006 20:40:03 +0100
Message-Id: <1165779603.27217.231.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Too bad PAE can't be detected at boot time; someone else mentioned that
> some recent Pentium M laptops (and anything older than PPro) don't boot
> if PAE is on.

even Windows has 2 kernel binaries for this case btw, it's really really
really hard.

> I want my hardware NX bit working in Ubuntu without having to recompile
> my kernel dammit.

other distros ship a PAE enabled kernel, and use that for NX enabled
machines (all NX capable machines support PAE obviously). I'm surprised
Ubuntu doesn't, maybe ask them? (Or use a distro that does have this)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

