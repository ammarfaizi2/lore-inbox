Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267336AbUGNJNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267336AbUGNJNm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 05:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267334AbUGNJNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 05:13:42 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:58082 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S267335AbUGNJNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 05:13:37 -0400
Date: Wed, 14 Jul 2004 10:32:18 +0200
From: Pavel Machek <pavel@suse.cz>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Arjan van de Ven <arjanv@redhat.com>, Daniel Phillips <phillips@istop.com>,
       sdake@mvista.com, David Teigland <teigland@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Message-ID: <20040714083218.GJ3654@openzaurus.ucw.cz>
References: <200407050209.29268.phillips@redhat.com> <200407101657.06314.phillips@redhat.com> <1089501890.19787.33.camel@persist.az.mvista.com> <200407111544.25590.phillips@istop.com> <20040711210624.GC3933@marowsky-bree.de> <1089615523.2806.5.camel@laptop.fenrus.com> <20040712100547.GF3933@marowsky-bree.de> <20040712101107.GA31013@devserv.devel.redhat.com> <20040712102124.GH3933@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040712102124.GH3933@marowsky-bree.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> However, of course this is more difficult for the case where you are in
> the write path needed to free some memory; alas, swapping to a GFS mount
> is probably a realllllly silly idea, too.

Swapping to GFS mount is *very* similar. If swapping to GFS can
not work, it is unlikely write support will be reliable.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

