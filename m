Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265574AbTFMXBj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 19:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265575AbTFMXBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 19:01:39 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:4756 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265574AbTFMXB3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 19:01:29 -0400
Date: Fri, 13 Jun 2003 16:11:35 -0700
From: Greg KH <greg@kroah.com>
To: LKML <linux-kernel@vger.kernel.org>,
       Sensors <sensors@stimpy.netroedge.com>
Subject: Re: [RFC PATCH] Add lm78 sensor chip support (2.5.70)
Message-ID: <20030613231135.GE2258@kroah.com>
References: <20030608223334.GC30962@earth.solarsys.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030608223334.GC30962@earth.solarsys.private>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 08, 2003 at 06:33:34PM -0400, Mark M. Hoffman wrote:
> This patch vs. 2.5.70 adds support for LM78, LM78-J, and LM79 sensors
> chips based on lm_sensors project CVS.  This works on one of my boards.

Do you want me to add this to the kernel tree?  Sorry I missed this in
the last round of i2c patches I sent out.

thanks,

greg k-h
