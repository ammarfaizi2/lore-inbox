Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751596AbWADH0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbWADH0W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 02:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751599AbWADH0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 02:26:22 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:29839 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751596AbWADH0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 02:26:21 -0500
Date: Wed, 4 Jan 2006 08:26:18 +0100
From: Tino Keitel <tino.keitel@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: No Coax digital out with SB Live! and 2.6.15
Message-ID: <20060104072618.GA10973@localhost.localdomain>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060103180831.GA5265@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060103180831.GA5265@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 19:08:31 +0100, Tino Keitel wrote:
> Hi folks,
> 
> since I upgraded to 2.6.15, the Coax digital output of my SB Live!
> stays silent. Analog output works. After reverting to 2.6.14.3 the
> digital output works again. Does anyone have a solution for this or at
> least the same problem?

I just tried alsa-driver 1.0.11-rc2 and now the digital out works again.

Regards,
Tino
