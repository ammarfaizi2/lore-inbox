Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317760AbSGWG0d>; Tue, 23 Jul 2002 02:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317961AbSGWG0d>; Tue, 23 Jul 2002 02:26:33 -0400
Received: from spud.dpws.nsw.gov.au ([203.202.119.24]:37115 "EHLO
	spud.dpws.nsw.gov.au") by vger.kernel.org with ESMTP
	id <S317760AbSGWG0c>; Tue, 23 Jul 2002 02:26:32 -0400
Message-Id: <sd3d8473.096@out-gwia.dpws.nsw.gov.au>
X-Mailer: Novell GroupWise Internet Agent 6.0.1
Date: Tue, 23 Jul 2002 16:29:24 +1000
From: "Daniel Lim" <Daniel.Lim@dpws.nsw.gov.au>
To: <linux-kernel@vger.kernel.org>
Subject: mkinitrd problem
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-NAIMIME-Disclaimer: 1
X-NAIMIME-Modified: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello there,
When I attempted to create the initial ramdisk images it failed with
loopback devices are in use!
# mkinitrd /boot/initrd-2.4.9-34.img 2.4.9-34
All of your loopback devices are in use!

Any idea ?
Much thanks.

Regards,
Daniel



 This e-mail message (and attachments) is confidential, and / or privileged and is intended for the use of the addressee only. If you are not the intended recipient of this e-mail you must not copy, distribute, take any action in reliance on it or disclose it to anyone. Any confidentiality or privilege is not waived or lost by reason of mistaken delivery to you. DPWS is not responsible for any information not related to the business of DPWS. If you have received this e-mail in error please destroy the original and notify the sender.

For information on services offered by DPWS, please visit our website at www.dpws.nsw.gov.au



