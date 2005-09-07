Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751031AbVIGFao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbVIGFao (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 01:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbVIGFao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 01:30:44 -0400
Received: from nudl.linbit.com ([212.69.162.21]:46059 "EHLO mail.linbit.com")
	by vger.kernel.org with ESMTP id S1751030AbVIGFan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 01:30:43 -0400
Date: Wed, 7 Sep 2005 07:30:36 +0200
From: Lars Ellenberg <Lars.Ellenberg@linbit.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Maurice Volaski <mvolaski@aecom.yu.edu>, drbd-user@linbit.com,
       linux-kernel@vger.kernel.org
Subject: Kernel 2.6.13 is NOT hiding devices from /dev [Was Why is the kernel hiding drbd devices?}
Message-ID: <20050907053036.GD6529@barkeeper1.linbit>
Mail-Followup-To: Lee Revell <rlrevell@joe-job.com>,
	Maurice Volaski <mvolaski@aecom.yu.edu>, drbd-user@lists.linbit.com,
	linux-kernel@vger.kernel.org
References: <a06230908bf43b486d98f@[129.98.90.227]> <1126063875.13159.31.camel@mindpipe> <a0623090dbf441d7a72a0@[129.98.90.227]> <1126069380.13159.51.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126069380.13159.51.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/ 2005-09-07 01:03:00 -0400
\ Lee Revell:
> On Wed, 2005-09-07 at 00:45 -0400, Maurice Volaski wrote:
> > >What is drbd?  An out of tree driver?  Did it work with 2.6.13-rcX?  If
> > 
> > Yes, it implements RAID 1 across two computers over a network link in 
> > realtime. Generally, you combine with a program called heartbeat to 
> > implement high-availabilty failover. It's very neat ;-)
> 
> They should get it merged then.  Anyway, I'm glad it's working...

will do, once we have it (or, the next generation of it) in shape.
maybe this year, probably next spring/summer ...

-- 
: Lars Ellenberg                                  Tel +43-1-8178292-0  :
: LINBIT Information Technologies GmbH            Fax +43-1-8178292-82 :
: Schoenbrunner Str. 244, A-1120 Vienna/Europe   http://www.linbit.com :
