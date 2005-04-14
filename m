Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbVDNRLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVDNRLi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 13:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVDNRLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 13:11:38 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:51143 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261551AbVDNRLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 13:11:33 -0400
Subject: spurious 8259A interrupt: IRQ7
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 14 Apr 2005 13:11:32 -0400
Message-Id: <1113498693.18871.11.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this message occasionally on both my machines.  I googled and saw
some references to this message on 2.4 but nothing for 2.6.  Some of the
references were to APIC, which I don't have enabled.

Both machines are using VIA chipsets and display the "VIA IRQ fixup"
message on boot.  I think this behavior started about the same time that
message started to appear.

On both machines the parallel port is disabled in the BIOS and there's
nothing on IRQ7.

Lee

