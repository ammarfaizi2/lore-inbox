Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263126AbUFNO1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbUFNO1R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 10:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbUFNO1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 10:27:17 -0400
Received: from holomorphy.com ([207.189.100.168]:38304 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263095AbUFNOT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 10:19:56 -0400
Date: Mon, 14 Jun 2004 07:19:42 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.7-rc3-mm2
Message-ID: <20040614141942.GF1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dominik Karall <dominik.karall@gmx.net>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net
References: <20040614021018.789265c4.akpm@osdl.org> <200406141620.01731.dominik.karall@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406141620.01731.dominik.karall@gmx.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 June 2004 11:10, Andrew Morton wrote:
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7-rc3/2.6
>>.7-rc3-mm2/

On Mon, Jun 14, 2004 at 04:19:52PM +0200, Dominik Karall wrote:
> I got following messages on startup of hotplug:
> usb 3-1: control timeout on ep0in
> usb 3-1: string descriptor 0 read error: -110
> usb 3-1: string descriptor 0 read error: -110

By any chance could you do bisection search on the patches in -mm?


-- wli
