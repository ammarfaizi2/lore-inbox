Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbVANAUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVANAUQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 19:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbVAMVsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 16:48:35 -0500
Received: from de01egw02.freescale.net ([192.88.165.103]:61115 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261738AbVAMVqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:46:53 -0500
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9ACC0FE8-65AC-11D9-B612-000393DBC2E8@freescale.com>
Content-Transfer-Encoding: 7bit
Cc: lkml Development <linux-kernel@vger.kernel.org>,
       sensors@stimpy.netroedge.com
From: Kumar Gala <kumar.gala@freescale.com>
Subject: I2C_TIMEOUT
Date: Thu, 13 Jan 2005 15:46:38 -0600
To: Greg KH <greg@kroah.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

What is the intended purpose of the I2C_TIMEOUT cmd?  It clearly sets 
the adapter timeout, I'm just trying to understand if there is a 
standard usage for the adapter's timeout.

thanks

- kumar

