Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbWCMSip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWCMSip (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWCMSio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:38:44 -0500
Received: from lame.durables.org ([64.81.244.120]:40591 "EHLO
	calliope.durables.org") by vger.kernel.org with ESMTP
	id S1750743AbWCMSio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:38:44 -0500
Subject: Re: [PATCH 18 of 20] ipath - kbuild infrastructure
From: Robert Walsh <rjwalsh@pathscale.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, rolandd@cisco.com, gregkh@suse.de,
       akpm@osdl.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
In-Reply-To: <20060313181025.GA13973@stusta.de>
References: <patchbomb.1141950930@eng-12.pathscale.com>
	 <867a396dd518ac63ab41.1141950948@eng-12.pathscale.com>
	 <20060313181025.GA13973@stusta.de>
Content-Type: text/plain
Date: Mon, 13 Mar 2006 10:38:36 -0800
Message-Id: <1142275116.4036.4.camel@phosphene.durables.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm still a bit surprised, since in the rest of the kernel we are even 
> going from -O2 to -Os for getting better performance.
> 
> Robert said he wanted to post some numbers showing that -O3 is 
> measurably better for you [1], but I haven't seen them.

As you might have guessed, I kind of forgot about this (I was swamped
with unrelated stuff.)  I'll try get someone else here at PathScale to
get these numbers.

Regards,
 Robert.

-- 
Robert Walsh                                 Email: rjwalsh@pathscale.com
PathScale, Inc.                              Phone: +1 650 934 8117
2071 Stierlin Court, Suite 200                 Fax: +1 650 428 1969
Mountain View, CA 94043.


