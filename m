Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317101AbSHYKNB>; Sun, 25 Aug 2002 06:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317102AbSHYKNB>; Sun, 25 Aug 2002 06:13:01 -0400
Received: from mta2n.bluewin.ch ([195.186.4.220]:57706 "EHLO mta2n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S317101AbSHYKNA>;
	Sun, 25 Aug 2002 06:13:00 -0400
Date: Sun, 25 Aug 2002 12:16:54 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Kernel Janitors ML 
	<kernel-janitor-discuss@lists.sourceforge.net>
Subject: Re: Broken inlines all over the source tree
Message-ID: <20020825101654.GA3707@k3.hellgate.ch>
Mail-Followup-To: Luca Barbieri <ldb@ldb.ods.org>,
	Linux-Kernel ML <linux-kernel@vger.kernel.org>,
	Kernel Janitors ML <kernel-janitor-discuss@lists.sourceforge.net>
References: <1030232838.1451.99.camel@ldb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1030232838.1451.99.camel@ldb>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.19 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Aug 2002 01:47:18 +0200, Luca Barbieri wrote:
> ./drivers/net/via-rhine.c

via_restart_tx() was already defined before use.
clear_tally_counters() is now fixed in my tree.

Thx.
