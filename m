Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbUKPVGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbUKPVGn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 16:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261815AbUKPVGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 16:06:43 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:28073 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261812AbUKPVGl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 16:06:41 -0500
Subject: Re: [patch] prefer TSC over PM Timer
From: john stultz <johnstul@us.ibm.com>
To: Dominik Brodowski <linux@dominikbrodowski.de>
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20041116202944.GA8982@dominikbrodowski.de>
References: <Pine.LNX.4.61.0411151531590.22091@twinlark.arctic.org>
	 <1100569104.21267.58.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0411151843190.22091@twinlark.arctic.org>
	 <1100598645.13732.22.camel@leatherman>
	 <20041116202944.GA8982@dominikbrodowski.de>
Content-Type: text/plain
Message-Id: <1100639185.21267.72.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 16 Nov 2004 13:06:26 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-16 at 12:29, Dominik Brodowski wrote:
> On Tue, Nov 16, 2004 at 01:50:44AM -0800, john stultz wrote: 
> > Dominik: are you cool with this?
> 
> I agree with handling TMTA specially, as it uses such a different approach
> to CPU frequency scaling _and_ gets TSC right. Therefore, ACK.

Dean: Ok, I'll defer to Dominik then. He's the expert on this. 

thanks
-john

