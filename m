Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266169AbUFPFIC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266169AbUFPFIC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 01:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266172AbUFPFIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 01:08:02 -0400
Received: from dirac.phys.uwm.edu ([129.89.57.19]:55178 "EHLO
	dirac.phys.uwm.edu") by vger.kernel.org with ESMTP id S266169AbUFPFIA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 01:08:00 -0400
Date: Wed, 16 Jun 2004 00:07:58 -0500 (CDT)
From: Bruce Allen <ballen@gravity.phys.uwm.edu>
To: Adam Radford <aradford@amcc.com>
cc: Peter Maas <fedora@rooker.dyndns.org>, linux-kernel@vger.kernel.org
Subject: RE: 3ware 9500S Drivers (mm kernel)
In-Reply-To: <HZDEQB01.6HW@hadar.amcc.com>
Message-ID: <Pine.GSO.4.21.0406160006310.12222-100000@dirac.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am also working with Bruce Allen (smartmontools developer) to make
> the 3w-9xxx driver work with smartmontools.  This shouldn't require
> any driver changes.

This should happen on the timescale of two weeks.  I've got a 9500 series
controller on hand and some SATA disks on order. Once the disks arrive,
with Adam's help it shouldn't take me long to get smartmontools working on
the 9500 series controllers.

The most novel aspect is that this will use the driver's character device
interface rather than the block interface.

Cheers,
	Bruce

