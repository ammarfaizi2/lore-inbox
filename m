Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbTIYRMK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 13:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbTIYRMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 13:12:09 -0400
Received: from fmr09.intel.com ([192.52.57.35]:45271 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S261262AbTIYRMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 13:12:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Shmulik Hen <shmulik.hen@intel.com>
Reply-To: shmulik.hen@intel.com
Organization: Intel corp.
To: "Chad N. Tindel" <chad@tindel.net>
Subject: Re: [Bonding-announce] [PATCH SET][bonding] cleanup
Date: Thu, 25 Sep 2003 20:11:53 +0300
User-Agent: KMail/1.4.3
Cc: bonding-devel@lists.sourceforge.net,
       bonding-announce@lists.sourceforge.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>, Jay Vosburgh <fubar@us.ibm.com>,
       "Noam, Amir" <amir.noam@intel.com>,
       "Mendelson, Tsippy" <tsippy.mendelson@intel.com>,
       "Noam, Marom" <noam.marom@intel.com>
References: <200309251549.59177.shmulik.hen@intel.com> <20030925164719.GA45241@calma.pair.com>
In-Reply-To: <20030925164719.GA45241@calma.pair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200309252011.53960.shmulik.hen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 September 2003 07:47 pm, Chad N. Tindel wrote:
> > patch 4 - remove dead code, old compatibility stuff and redundant
> >           checks.
>
> I'm a bit concerned about doing some of this stuff in the 2.4
> series.  That compatibility stuff is there for a reason, and was
> set to be removed in 2.6.  Perhaps we shouldn't be doing stuff this
> drastic until 2.6 because of the risk of breaking users.

That's the word I got from Jay in response to the " [Kernel-janitors] 
old ioctl definitions in 2.5" thread.

>Jay Vosburgh <fubar@us.ibm.com> wrote:
>	I was going to add it on to the end of the clean up set, but
> if you want to do it, go ahead.  Nobody seems to have objected to
> removing the _OLD stuff, which I view as a good thing.

-- 
| Shmulik Hen   Advanced Network Services  |
| Israel Design Center, Jerusalem          |
| LAN Access Division, Platform Networking |
| Intel Communications Group, Intel corp.  |

