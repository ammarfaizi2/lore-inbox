Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265654AbUFOO02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265654AbUFOO02 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 10:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265668AbUFOO02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 10:26:28 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:46976 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S265654AbUFOO01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 10:26:27 -0400
Date: Tue, 15 Jun 2004 14:26:26 +0000
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: hp omnibook xe4500 and keyboard
Message-ID: <20040615142626.A6275@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I am having hp omnibook xe4500 which has an integrated keyboard and I am
having also external USB mouse. There is an internal mouse inside.

What should I tick up in 2.4.25 in "Input core" and "USB HID" so that
1) keyboard works upon bootup
2) USB mouse works

I have determined these things are dependent on almost everything in the
kernel configuration, for example CONFIG_AGP and CONFIG_DRM.

Cl<
