Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbUDNOVP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 10:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUDNOVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 10:21:15 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:58029 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S261322AbUDNOVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 10:21:14 -0400
X-Sasl-enc: db9R3Pd3ttkjJazvZXm4uw 1081952362
Message-ID: <407D4869.3010303@fastmail.fm>
Date: Wed, 14 Apr 2004 16:19:21 +0200
From: Igor Bukanov <igor@fastmail.fm>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Fwd: drivers/usb/emi26_fw.h has a non-free license
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ This was originally reported at 
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=242895 ]

Date: Fri, 9 Apr 2004 15:50:11 +0200
From: Bill Allombert
...


The file drivers/usb/emi26_fw.h carry the license below:
/*
  * This firmware is for the Emagic EMI 2|6 Audio Interface
  *
  * The firmware contained herein is Copyright (c) 1999-2002 Emagic
  * as an unpublished work. This notice does not imply unrestricted
  * or public access to this firmware which is a trade secret of Emagic,
  * and which may not be reproduced, used, sold or transferred to
  * any third party without Emagic's written consent. All Rights Reserved.
  *
  * This firmware may not be modified and may only be used with the
  * Emagic EMI 2|6 Audio Interface. Distribution and/or Modification of
  * any driver which includes this firmware, in whole or in part,
  * requires the inclusion of this statement.
  */

Do we have Emagic's written consent to distribute it ?

This file is #include'd in the drivers/usb/emi26.c GPL module by
Tapio Laxström.

