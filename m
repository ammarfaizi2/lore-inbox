Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWCORcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWCORcU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 12:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWCORcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 12:32:20 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:15771 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750722AbWCORcT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 12:32:19 -0500
Subject: Re: 2.6.16-rc6-mm1 : Setting clocksource results in error
From: john stultz <johnstul@us.ibm.com>
To: Alexander Gran <alex@zodiac.dnsalias.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200603151828.34416@zodiac.zodiac.dnsalias.org>
References: <200603140935.26927@zodiac.zodiac.dnsalias.org>
	 <200603151153.18873@zodiac.zodiac.dnsalias.org>
	 <1142442974.8797.12.camel@cog.beaverton.ibm.com>
	 <200603151828.34416@zodiac.zodiac.dnsalias.org>
Content-Type: text/plain
Date: Wed, 15 Mar 2006 09:32:14 -0800
Message-Id: <1142443934.8797.22.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-15 at 18:28 +0100, Alexander Gran wrote:
> Oh sorry. Lilo got mad my automated kernel-install-script, so I was using the 
> unpatched kernel again. Works as expected!

Great to hear! Thanks for the testing!
-john


