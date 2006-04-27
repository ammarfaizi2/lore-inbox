Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751642AbWD0UwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbWD0UwQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 16:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751649AbWD0UwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 16:52:16 -0400
Received: from 10.121.9.213.dsl.getacom.de ([213.9.121.10]:30913 "EHLO
	ds666.l4x.org") by vger.kernel.org with ESMTP id S1751642AbWD0UwP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 16:52:15 -0400
Message-ID: <44512EF0.2090700@ppp0.net>
Date: Thu, 27 Apr 2006 22:52:00 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20060228 Thunderbird/1.5 Mnenhy/0.6.0.104
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, ak@suse.de,
       linux-kernel@vger.kernel.org
References: <20060427014141.06b88072.akpm@osdl.org>	<p73vesv727b.fsf@bragg.suse.de>	<20060427121930.2c3591e0.akpm@osdl.org>	<200604272126.30683.ak@suse.de>	<20060427124452.432ad80d.rdunlap@xenotime.net> <20060427131100.05970d65.akpm@osdl.org>
In-Reply-To: <20060427131100.05970d65.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 192.168.1.149
X-SA-Exim-Mail-From: jdittmer@ppp0.net
Subject: Re: checklist (Re: 2.6.17-rc2-mm1)
X-SA-Exim-Version: 4.2.1 (built Mon, 27 Mar 2006 13:42:28 +0200)
X-SA-Exim-Scanned: Yes (on ds666.l4x.org)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Adrian does some of the other steps.  I'm not aware of anyone who is doing
> regular sparse and kernel-doc checking on -mm.

Sparse checks are in the results at http://l4x.org/k/ . There is just
someone missing who looks at the results :(

Jan
