Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbUDTJXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUDTJXE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 05:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbUDTJXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 05:23:03 -0400
Received: from cpmx.mail.saic.com ([139.121.17.160]:6324 "EHLO cpmx.saic.com")
	by vger.kernel.org with ESMTP id S262391AbUDTJNp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 05:13:45 -0400
Subject: e100 NETDEV WATCHDOG transmit timeout since 2.6.4
From: Eamonn Hamilton <EAMONN.HAMILTON@saic.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1082452412.4268.20.camel@ukabzc383.uk.saic.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 20 Apr 2004 10:13:33 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since 2.6.4 my ethernet interface is timing out after successfully
operating for 30 minutes or so, and is reset by the watchdog and runs
for another 30 minutes or so. This behaviour is only since 2.6.4 when I
believe a rewrite of the code was done. I've tried it with acpi
disabled, and got the same results if this helps.

Anybody got any ideas?

Cheers,
Eamonn
-- 
Eamonn Hamilton <hamiltonea@uk-aberdeen.mail.saic.com>

