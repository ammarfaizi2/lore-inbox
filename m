Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWEZMnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWEZMnD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 08:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWEZMnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 08:43:01 -0400
Received: from ns2.suse.de ([195.135.220.15]:64961 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750723AbWEZMnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 08:43:00 -0400
From: Andi Kleen <ak@suse.de>
To: Ingo Oeser <netdev@axxeo.de>
Subject: Re: Safe remote kernel install howto (Re: [Bugme-new] [Bug 6613] New: iptables broken on 32-bit PReP (ARCH=ppc))
Date: Fri, 26 May 2006 14:42:32 +0200
User-Agent: KMail/1.9.1
Cc: Meelis Roos <mroos@linux.ee>, kernel list <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
References: <200605251004.k4PA4Lek007751@fire-2.osdl.org> <Pine.SOC.4.61.0605261008090.14762@math.ut.ee> <200605261429.36078.netdev@axxeo.de>
In-Reply-To: <200605261429.36078.netdev@axxeo.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605261442.32319.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 4. Put "sysctl -w kernel.panic_on_oops=1" as early as possible
>      in your boot scripts[1].

You can as well boot with oops=panic

-Andi
