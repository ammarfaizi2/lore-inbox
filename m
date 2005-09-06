Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbVIFScN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbVIFScN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 14:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbVIFScN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 14:32:13 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:28384
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1750780AbVIFScM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 14:32:12 -0400
Reply-To: <abonilla@linuxwireless.org>
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: <netdev@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: IPW2100 Kconfig
Date: Tue, 6 Sep 2005 12:32:11 -0600
Message-ID: <005101c5b311$4ca69a50$a20cc60a@amer.sykes.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I checked the IPW2100 in the current git from linux-2.6 and the menuconfig
help (Kconfig) says you need to put the firmware in /etc/firmware, it should
be /lib/firmware.

Who should I send the "patch" to? Or can someone simply change that?

Thanks,

.Alejandro

