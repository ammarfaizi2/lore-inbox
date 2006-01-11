Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030282AbWAKG6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbWAKG6m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 01:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030303AbWAKG6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 01:58:42 -0500
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:32647 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030282AbWAKG6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 01:58:41 -0500
Message-Id: <20060111064746.560312000.dtor_core@ameritech.net>
Date: Wed, 11 Jan 2006 01:47:46 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>
Subject: [patch 0/6] Assorted conversions to the new platform device interface 
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

The following patches attempt to convert bunch of drivers to the new
platform device interface so that later we can drop
platform_device_register_simple() interface.

I tried CCing authors or maintainers of the core in question earlier,
these are the ones I did not get any freedback on so they must be
perfect ;)

I wonder if you could add these to -mm for now.

Thanks!

--
Dmitry

