Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264698AbTFAS2H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 14:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264700AbTFAS2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 14:28:07 -0400
Received: from [195.208.223.238] ([195.208.223.238]:8320 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264698AbTFAS1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 14:27:30 -0400
Date: Sun, 1 Jun 2003 22:40:26 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Ben Collins <bcollins@debian.org>
Cc: Willy Tarreau <willy@w.ods.org>, Jason Papadopoulos <jasonp@boo.net>,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: Linux 2.4.21-rc3 : IDE pb on Alpha
Message-ID: <20030601224026.A642@localhost.park.msu.ru>
References: <5.2.1.1.2.20030526232835.00a468e0@boo.net> <20030527045302.GA545@alpha.home.local> <20030527134017.B3408@jurassic.park.msu.ru> <20030527123152.GA24849@alpha.home.local> <20030527180403.A2292@jurassic.park.msu.ru> <20030531152417.GY13766@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030531152417.GY13766@phunnypharm.org>; from bcollins@debian.org on Sat, May 31, 2003 at 11:24:17AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 31, 2003 at 11:24:17AM -0400, Ben Collins wrote:
> I just tried this patch, and for the first time in a long time, I've
> been able to boot with UDMA(66) enabled and not get the corruption.

Excellent, thanks for the report. :-)

Ivan.
