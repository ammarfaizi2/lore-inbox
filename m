Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbVGPQoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVGPQoR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 12:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbVGPQoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 12:44:16 -0400
Received: from femail.waymark.net ([206.176.148.84]:34217 "EHLO
	femail.waymark.net") by vger.kernel.org with ESMTP id S261671AbVGPQoP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 12:44:15 -0400
Date: 16 Jul 2005 16:32:14 GMT
From: Kenneth Parrish <Kenneth.Parrish@family-bbs.org>
Subject: Re: 2.6.13-rc3 ACPI regression and hang on x86-64
To: linux-kernel@vger.kernel.org
Message-ID: <b03f6a.f05c07@family-bbs.org>
Organization: FamilyNet HQ
X-Mailer: BBBS/NT v4.01 Flag-5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-=> Mikael Pettersson wrote to All <=-

 MP> With the i386 kernel, 2.6.13-rc3 mostly works, but
 MP> it fails to detect the CPU's C2 state.
This kernel fails to boot, occasionally, stopping at the system BIOS
check successful message, but got C2 back with the recent patch here.
LILO version 22.5.9 and Cyrix/VIA e-machines '99. I might be able to
provide more information.

... Mars' surface air pressure is less than where high-altitude jets fly here.
--- MultiMail/Linux v0.46
