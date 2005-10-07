Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030469AbVJGPy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030469AbVJGPy7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 11:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030470AbVJGPy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 11:54:58 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:34952
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1030468AbVJGPy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 11:54:58 -0400
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, jketreno@linux.intel.com
Subject: IPW2100 Kconfig is WRONG!
Date: Fri, 7 Oct 2005 11:54:53 -0400
Message-Id: <20051007154953.M47622@linuxwireless.org>
X-Mailer: Open WebMail 2.40 20040816
X-OriginatingIP: 16.126.157.6 (abonilla@linuxwireless.org)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

AGAIN, the location that the Kconfig of ipw2100 says to put the FW in
2.6.14-rc3-Git is WRONG. It should be /lib/firmware, not /etc/firmware.

I have already sent a patch with this and Jesper Juhl also signed it and sent
one in too. What did I/Jesper did wrong?

.Alejandro

