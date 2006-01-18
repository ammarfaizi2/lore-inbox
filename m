Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbWARCrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbWARCrS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 21:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWARCrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 21:47:18 -0500
Received: from soohrt.org ([85.131.246.150]:13033 "EHLO quickstop.soohrt.org")
	by vger.kernel.org with ESMTP id S964844AbWARCrR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 21:47:17 -0500
Date: Wed, 18 Jan 2006 03:47:10 +0100
From: Horst Schirmeier <horst@schirmeier.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: udev/hotplug and automatic /dev node creation
Message-ID: <20060118024710.GB26895@quickstop.soohrt.org>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm looking for documentation regarding how to write a Linux kernel
module that creates its own /dev node via udev/hotplug.
register_chrdev() and a simple udev/rules.d/ entry don't seem to be
sufficient...

Any suggestions on where to start reading are welcome.

Kind regards,
 Horst

-- 
PGP-Key 0xD40E0E7A
