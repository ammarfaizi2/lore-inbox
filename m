Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271703AbTG2PsT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 11:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271712AbTG2PsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 11:48:19 -0400
Received: from indianer.linux-kernel.at ([212.24.125.53]:665 "EHLO
	indianer.linux-kernel.at") by vger.kernel.org with ESMTP
	id S271703AbTG2Pqt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 11:46:49 -0400
Message-Id: <200307291544.h6TFicBV004820@indianer.linux-kernel.at>
From: Oliver Pitzeier <oliver@linux-kernel.at>
To: WHarms@bfs.de, linux-kernel@vger.kernel.org
Subject: RE: bug alpha configure linux-2.6.0-test1
Date: Tue, 29 Jul 2003 17:46:05 +0200
Organization: Linux Kernel Austria
X-Mailer: Oracle Outlook Connector 3.4 40812
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MailScanner-Information: Please contact your Internet E-Mail Service Provider for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Walter!

> i tried the new linux-2.6.0-test1 with my alpha and the
> config says:
> 
> ./scripts/kconfig/mconf arch/alpha/Kconfig
> boolean symbol BINFMT_ZFLAT tested for 'm'? test forced to 'n'
> #
> # using defaults found in arch/alpha/defconfig
> #
> arch/alpha/defconfig:244: trying to assign nonexistent symbol 
> SCSI_NCR53C8XX

You are still hanging around with -test1? :) Give -test2 a try! It runs's great for me, but -test1 did also... But we talk about this already...

Best regards,
 Oliver

