Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264330AbTLPDwX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 22:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264332AbTLPDwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 22:52:23 -0500
Received: from smtp-relay.dca.net ([216.158.48.66]:23174 "EHLO
	smtp-relay.dca.net") by vger.kernel.org with ESMTP id S264330AbTLPDwW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 22:52:22 -0500
Date: Mon, 15 Dec 2003 22:52:19 -0500
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Sensors <sensors@stimpy.netroedge.com>
Subject: [PATCH 2.6] sensors chip updates
Message-ID: <20031216035219.GA1658@earth.solarsys.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg:

The following are four patchsets for 2.6 which were either direct
from or inspired by recent updates in the lm_sensors CVS.

These patches should be applied, in order, on top of your -test11
megapatch [1].  Please queue these up for inclusion after 2.6.0.

LKML: please CC me on comments, thanks

[1] http://www.kernel.org/pub/linux/kernel/people/gregkh/i2c/2.6/2.6.0-test11/i2c-devel-2.6.0-test11.patch

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

