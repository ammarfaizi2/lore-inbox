Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136620AbRECOf1>; Thu, 3 May 2001 10:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136818AbRECOfT>; Thu, 3 May 2001 10:35:19 -0400
Received: from ns.viventus.no ([195.18.200.139]:53519 "EHLO viventus.no")
	by vger.kernel.org with ESMTP id <S136620AbRECOfG>;
	Thu, 3 May 2001 10:35:06 -0400
From: Rafael Martinez <rafael@viewpoint.no>
To: linux-kernel@vger.kernel.org
Reply-To: rafael@viewpoint.no
Subject: Solution - AMI  megaraid driver doesn't work with Linux 2.4.x kernels
Date: Thu, 03 May 2001 16:37:13 +0100 (CEST)
X-Mailer: XCmail 1.2 - with PGP support, PGP engine version 0.5 (Linux)
X-Mailerorigin: http://www.fsai.fh-trier.de/~schmitzj/Xclasses/XCmail/
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Message-ID: <auto-000000185389@viventus.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hei

The Ami megatrends driver (at least for 471, 475, and 493) does not work 
with 2.4.x kernels.

The solution we got from Ami is to update the firmware of these cards to
version FW G158. This update will fix all the problems with ami
raid-devices in 2.4.x kernel without changing the driver.

We don't know when AMI will release a fixed firmware (hope soon) but we got it by
e-mail. If there is anybody with the same problem I can sent the
firmware-update by mail.

Sincerely
Rafael Martinez


