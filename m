Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbTKLCJz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 21:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbTKLCJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 21:09:55 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:42640 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261433AbTKLCJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 21:09:54 -0500
Date: Tue, 11 Nov 2003 18:35:07 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erlend Aasland <erlend-a@ux.his.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 /proc/interrupts fails on systems with many CPUs
Message-ID: <68230000.1068604507@flay>
In-Reply-To: <20031111233751.GA17514@badne3.ux.his.no>
References: <BF1FE1855350A0479097B3A0D2A80EE0013B1188@hdsmsx402.hd.intel.com> <1068580528.26160.12.camel@dhcppc4> <20031111233751.GA17514@badne3.ux.his.no>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is a bit OT in this thread but...
> Doesn't the information in /proc/interrupts really belong somewhere in sysfs?

Only if you want to open 10 billion files to get the data every time.

M.

