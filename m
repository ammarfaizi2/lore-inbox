Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbVANTQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbVANTQG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 14:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbVANTQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 14:16:00 -0500
Received: from de01egw02.freescale.net ([192.88.165.103]:44493 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S262042AbVANTO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 14:14:29 -0500
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <804898BA-6660-11D9-A893-000393DBC2E8@freescale.com>
Content-Transfer-Encoding: 7bit
Cc: lkml Development <linux-kernel@vger.kernel.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: unregisters a device that doesnt exist
Date: Fri, 14 Jan 2005 13:14:23 -0600
To: Greg KH <greg@kroah.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible to unregister a device (more specifically a 
platform_device) if its hasnt already be registered?  If not, is there 
a way to determine if the device has been registered.

- kumar

