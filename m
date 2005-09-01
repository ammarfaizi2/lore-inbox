Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965128AbVIANvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965128AbVIANvk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 09:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965132AbVIANvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 09:51:35 -0400
Received: from users.ccur.com ([208.248.32.211]:53947 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S965131AbVIANvc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 09:51:32 -0400
Date: Thu, 1 Sep 2005 09:50:49 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>, akpm@osdl.org,
       george@mvista.com, johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: FW: [RFC] A more general timeout specification
Message-ID: <20050901135049.GB1753@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <F989B1573A3A644BAB3920FBECA4D25A042B030A@orsmsx407> <Pine.LNX.4.61.0509010136350.3743@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0509010136350.3743@scrub.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 01:50:33AM +0200, Roman Zippel wrote:
> When you convert a user time to kernel time you can
> automatically validate

Kernel time sucks.  It is just a single clock, it may not have
the attributes of the clock that the user really wished to use.

Joe
