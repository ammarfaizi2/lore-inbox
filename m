Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVCIO0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVCIO0Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 09:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbVCIO0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 09:26:16 -0500
Received: from inutil.org ([193.22.164.111]:16771 "EHLO
	vserver151.vserver151.serverflex.de") by vger.kernel.org with ESMTP
	id S261633AbVCIO0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 09:26:15 -0500
Date: Wed, 9 Mar 2005 15:26:13 +0100
To: linux-kernel@vger.kernel.org
Subject: Average power consumption in S3?
Message-ID: <20050309142612.GA6049@informatik.uni-bremen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: Moritz Muehlenhoff <jmm@inutil.org>
X-SA-Exim-Connect-IP: 134.102.117.43
X-SA-Exim-Mail-From: jmm@inutil.org
X-SA-Exim-Scanned: No (on vserver151.vserver151.serverflex.de); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm using an IBM Thinkpad X31. With stock 2.6.11 and the additional
radeontool to power-off the backlight in suspend, S3 works very well
and reliable. During S3 I've measured a power consumption of 1400
to 1500 mWh (using 512 megabytes of RAM). Is there still room for
optimization? What's the typical amount of energy required for suspend-
to-ram? From friends using iBooks with MacOS X I've heard that they
left the notebook in suspend when leaving for a week and could still
use it after return.

Cheers,
        Moritz
