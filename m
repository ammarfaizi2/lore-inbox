Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265502AbUFOM6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265502AbUFOM6D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 08:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265503AbUFOM6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 08:58:03 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:43392 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S265502AbUFOM6B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 08:58:01 -0400
Date: Tue, 15 Jun 2004 12:58:00 +0000
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: HID vs. Input Core
Message-ID: <20040615125800.B5811@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I would like to know what's the difference between
Input Core (CONFIG_INPUT) and USB HID (CONFIG_USB_HID) in 2.4.25

They seem to enable the same thing - USB HID. However I don't
know which one should I enable or if I should enable both. I find
existence of two options with seemingly the same function confusing.

Cl<
