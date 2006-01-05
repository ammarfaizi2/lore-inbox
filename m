Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752179AbWAETcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbWAETcW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 14:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752180AbWAETcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 14:32:22 -0500
Received: from main.gmane.org ([80.91.229.2]:52365 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1752179AbWAETcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 14:32:21 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Alexander Fieroch <fieroch@web.de>
Subject: "acpi_power_off called", PC does not shut down
Date: Thu, 05 Jan 2006 20:31:36 +0100
Message-ID: <dpjs6r$ci6$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: osten.wh.uni-dortmund.de
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: de-de, en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The last two lines of messages are:

Power down.
acpi_power_off called

The PC does not shut down with kernel 2.6.14 and 2.6.15. Using kernel
2.6.13 the PC does shut down.

Asus P5GD2 Premium mainboard, AMI BIOS, Intel 915P+ICH6R


Regards,
Alexander

