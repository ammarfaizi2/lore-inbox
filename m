Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264155AbUD2L6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264155AbUD2L6a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 07:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264193AbUD2L6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 07:58:30 -0400
Received: from mail.shareable.org ([81.29.64.88]:38784 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264155AbUD2L63
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 07:58:29 -0400
Date: Thu, 29 Apr 2004 12:57:38 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ross Dickson <ross@datscreative.com.au>
Cc: Jesse Allen <the3dfxdude@hotmail.com>, Len Brown <len.brown@intel.com>,
       a.verweij@student.tudelft.nl,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Craig Bradney <cbradney@zip.com.au>, christian.kroener@tu-harburg.de,
       linux-kernel@vger.kernel.org, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Daniel Drake <dan@reactivated.net>, Ian Kumlien <pomac@vapor.com>,
       Allen Martin <AMartin@nvidia.com>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH] for idle=C1halt, 2.6.5
Message-ID: <20040429115738.GA7077@mail.shareable.org>
References: <Pine.GHP.4.44.0404271807470.6154-100000@elektron.its.tudelft.nl> <200404282133.34887.ross@datscreative.com.au> <20040428205938.GA1995@tesore.local> <200404292144.37479.ross@datscreative.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404292144.37479.ross@datscreative.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Dickson wrote:
> Not as bizarre as you may think. I have heard coils and even capacitors "sing"
> in years past whilst servicing electronics.

See the thread "Increasing HZ (patch for HZ > 1000)" for something
along these lines.  The change of HZ from 100 to 1000 causes some
notebooks to make a noise.

(Mine makes a noise with both, though).

-- Jamie
