Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270387AbUJWCCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270387AbUJWCCu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 22:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269496AbUJWB7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 21:59:30 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:15116 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S269347AbUJWBuS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 21:50:18 -0400
Date: Fri, 22 Oct 2004 21:51:12 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [patch netdev-2.6 0/2] r8169: vlan hwaccel fixes
Message-ID: <20041023015111.GC32031@tuxdriver.com>
Mail-Followup-To: Francois Romieu <romieu@fr.zoreil.com>,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com
References: <20041022005737.GA1945@tuxdriver.com> <20041022202851.GB4216@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022202851.GB4216@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 10:28:51PM +0200, Francois Romieu wrote:
> John W. Linville <linville@tuxdriver.com> :
> > Patch 2:
> [nice explanation]
> 
> Any objection against me replacing the actual comment of patch #2 (i.e.
> "why" instead of "how") and splitting the "if ((tp->>vlgrp = grp))" over
> two lines ?

Not quite sure which comment you mean, but I'm sure that's fine.
I posted a third patch to fix-up that tricky if() -- you're right,
it is a little TOO clever... :-)

John
-- 
John W. Linville
linville@tuxdriver.com
