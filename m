Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVFTOKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVFTOKT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 10:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVFTOKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 10:10:19 -0400
Received: from dvhart.com ([64.146.134.43]:13745 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261256AbVFTOI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 10:08:26 -0400
Date: Mon, 20 Jun 2005 07:08:27 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Takashi Iwai <tiwai@suse.de>, Dave Jones <davej@redhat.com>
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Subject: Re: kernel bugzilla
Message-ID: <181620000.1119276507@[10.10.2.4]>
In-Reply-To: <s5hwtopp7e5.wl%tiwai@suse.de>
References: <20050617001330.294950ac.akpm@osdl.org><1119016223.5049.3.camel@mulgrave><20050617142225.GO6957@suse.de><20050617141003.2abdd8e5.akpm@osdl.org><20050617212338.GA16852@suse.de><491950000.1119044739@flay><20050618191341.GA30620@redhat.com> <s5hwtopp7e5.wl%tiwai@suse.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It'd be nice if these (exported) bugzilla systems can notify to the
> corresponding devel ML, e.g. alsa-devel in the case of ALSA, so that
> the reports surely reach to developers.

That's easily fixable. However, it's likely to irritate SOME people on
each list. What I suggest is subscribing to bugme-new@lists.osdl.org,
(which will get you one email for each new bug) and have someone in that 
group take responsiblity for forwarding new bugs in the relevant 
categories to the list (there are headers to filter on). A simple 
procmail filter should suffice ... but I'm not willing to take
responsibility for automated emailt to lists I'm not even subscribed to ;-)

M.

