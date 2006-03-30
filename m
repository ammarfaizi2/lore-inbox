Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbWC3S1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWC3S1D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 13:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWC3S1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 13:27:00 -0500
Received: from systemlinux.org ([83.151.29.59]:40637 "EHLO m18s25.vlinux.de")
	by vger.kernel.org with ESMTP id S1751362AbWC3S07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 13:26:59 -0500
Date: Thu, 30 Mar 2006 20:26:43 +0200
From: Andre Noll <maan@systemlinux.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, beware <wimille@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Float numbers in module programming
Message-ID: <20060330182643.GV27173@skl-net.de>
References: <3fd7d9680603290634n6fabcdc7r193c30447acc1858@mail.gmail.com> <Pine.LNX.4.61.0603290955440.27913@chaos.analogic.com> <Pine.LNX.4.61.0603301010400.30783@yvahk01.tjqt.qr> <Pine.LNX.4.61.0603300739050.32259@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0603300739050.32259@chaos.analogic.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08:09, linux-os (Dick Johnson) wrote:

> For instance __all__ real numbers, except for transcendentals, can
> be represented as a ratio of two integers.

Nope. It was known already to Euklid (300 before christ) that the real
number sqrt(2) can _not_ be represented as ratio of two integers. Of
course, sqrt(2) is not transcendental because it is a zero of x^2 -
2, a polynomial with integer coefficients.

Andre
-- 
The only person who always got his work done by Friday was Robinson Crusoe
