Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbTKOQPO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 11:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbTKOQPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 11:15:14 -0500
Received: from wblv-224-88.telkomadsl.co.za ([165.165.224.88]:5249 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S261801AbTKOQPM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 11:15:12 -0500
Subject: Carrier detection for network interfaces
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1068912989.5033.32.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 15 Nov 2003 18:16:29 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Is there any proper way to detect a carrier signal with network
interfaces ?  I have recently come across a problem where we tried
to do with with checking for 'RUNNING', which do not work for all
drivers, as well as mii-tool that fails in some cases.


Thanks,

--
Martin Schlemmer

