Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbVL2DCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbVL2DCc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 22:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbVL2DCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 22:02:32 -0500
Received: from mail4.worldserver.net ([217.13.200.24]:50886 "EHLO
	mail4.worldserver.net") by vger.kernel.org with ESMTP
	id S964982AbVL2DCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 22:02:32 -0500
X-Speedbone-Mail4Scanner-Mail-From: christian@leber.de via mail4.worldserver.net
X-Speedbone-Mail4Scanner: 1.25st (Clear:RC:1(84.171.173.150):. Processed in 0.025391 secs Process 3668)
Date: Thu, 29 Dec 2005 04:02:28 +0100
From: Christian Leber <christian@leber.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.15-rc7 ALSA sound/usb/usbaudio.c:801: cannot submit datapipe for urb
Message-ID: <20051229030227.GA7578@core.home>
References: <20051228223742.GA23531@core.home> <1135810567.7680.8.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135810567.7680.8.camel@mindpipe>
X-Location: Europe, Germany, Mannheim
X-Operating-System: Debian GNU/Linux (sid)
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2005 at 05:56:07PM -0500, Lee Revell wrote:

> Disable CONFIG_USB_BANDWIDTH and it will work.

Yes, it works.
Thank you.

> Which host controller driver are you using?

uhci
(http://debian.christian-leber.de/log)


Christian Leber

-- 
  "Omnis enim res, quae dando non deficit, dum habetur et non datur,
   nondum habetur, quomodo habenda est."       (Aurelius Augustinus)
  Translation: <http://gnuhh.org/work/fsf-europe/augustinus.html>
