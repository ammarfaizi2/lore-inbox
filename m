Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265521AbUFONDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265521AbUFONDY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 09:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265531AbUFONDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 09:03:24 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:43648 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S265521AbUFONDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 09:03:20 -0400
Date: Tue, 15 Jun 2004 13:03:19 +0000
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: make menuconfig help bugreport
Message-ID: <20040615130319.C5811@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

If I go to the line in make menuconfig reading "USB Human Interface Devices (HID)"
and enter <Help> I get
"There is no help available for this option".

Maybe the help is not intended to be there.

However what I consider being a bug is that when I <Exit> from the help, the cursor
jumps at the start of the USB chapter and because USB is lenghty the original
position is lost.

This doesn't happem for other entries wher <Help> is available.

Cl<
