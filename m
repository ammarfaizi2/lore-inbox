Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030918AbWKOTTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030918AbWKOTTX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030697AbWKOTTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:19:23 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:27612 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1030922AbWKOTTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:19:20 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <455B6823.2080007@s5r6.in-berlin.de>
Date: Wed, 15 Nov 2006 20:18:59 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Luca Tettamanti <kronos.it@gmail.com>
CC: Ben Collins <bcollins@debian.org>, linux1394-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sbp2: make 1bit bitfield unsigned
References: <20061115181415.GA26751@dreamland.darkstar.lan>
In-Reply-To: <20061115181415.GA26751@dreamland.darkstar.lan>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca Tettamanti wrote:
> A signed single-bit bitfield doesn't make much sense. Make it unsigned.
...
Committed to linux1394-2.6.git.
-- 
Stefan Richter
-=====-=-==- =-== -====
http://arcgraph.de/sr/
