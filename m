Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264879AbTLRAJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 19:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbTLRAJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 19:09:59 -0500
Received: from mail.kroah.org ([65.200.24.183]:63634 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264879AbTLRAJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 19:09:58 -0500
Date: Wed, 17 Dec 2003 16:04:33 -0800
From: Greg KH <greg@kroah.com>
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Sensors <sensors@stimpy.netroedge.com>
Subject: Re: [PATCH 2.6] sensors chip updates
Message-ID: <20031218000433.GE6258@kroah.com>
References: <20031216035219.GA1658@earth.solarsys.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031216035219.GA1658@earth.solarsys.private>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 15, 2003 at 10:52:19PM -0500, Mark M. Hoffman wrote:
> Hi Greg:
> 
> The following are four patchsets for 2.6 which were either direct
> from or inspired by recent updates in the lm_sensors CVS.
> 
> These patches should be applied, in order, on top of your -test11
> megapatch [1].  Please queue these up for inclusion after 2.6.0.

Thanks, I've applied all 4 of these to my "after 2.6.0" i2c tree.

greg k-h
