Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135763AbRDYAOl>; Tue, 24 Apr 2001 20:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135764AbRDYAOa>; Tue, 24 Apr 2001 20:14:30 -0400
Received: from china.patternbook.com ([216.254.75.60]:20210 "EHLO
	free.transpect.com") by vger.kernel.org with ESMTP
	id <S135763AbRDYAOS>; Tue, 24 Apr 2001 20:14:18 -0400
Date: Tue, 24 Apr 2001 20:14:03 -0500
From: Whit Blauvelt <whit@transpect.com>
To: linux-kernel@vger.kernel.org
Subject: 2.2.19 Realaudio masq problem
Message-ID: <20010424201403.A1909@free.transpect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Release Notes say "Fix problems with realaudio masquerading". Looked
promising, since with 2.2.17 one masqueraded system (but not another) was
having occassional problems with realaudio at some (but not all) sites.

Compiled 2.2.19 with 'make oldconfig,' no to new options. Otherwise running
with the same firewall and masquerading settings (and yes I built and
installed ip_masq_raudio.o). Masquerading is otherwise working, but now
neither masqueraded system can connect with realaudio - the realplay routine
to find a way to make a connection automatically fails for both.

Please cc me, not subscribed.

Thanks,
Whit 
whit@transpect.com
