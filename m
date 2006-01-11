Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932739AbWAKACF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932739AbWAKACF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 19:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932752AbWAKACF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 19:02:05 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:22979 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932744AbWAKACA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 19:02:00 -0500
Subject: Re: [PATCH 7/10] NTP: remove time_tolerance
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0512220025550.30921@scrub.home>
References: <Pine.LNX.4.61.0512220025550.30921@scrub.home>
Content-Type: text/plain
Date: Tue, 10 Jan 2006 16:01:55 -0800
Message-Id: <1136937716.2890.15.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-22 at 00:26 +0100, Roman Zippel wrote:
> time_tolerance isn't changed at all in the kernel, so simply remove it
> and use a constant instead, this simplifies the next patch, as it avoids
> a number of conversions.
> 
> Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

This is a good cleanup.

Acked-by: John Stultz <johnstul@us.ibm.com>

thanks
-john

