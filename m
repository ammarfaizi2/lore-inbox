Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWHIVws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWHIVws (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 17:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWHIVwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 17:52:47 -0400
Received: from mail.visionpro.com ([63.91.95.13]:52616 "EHLO
	chicken.machinevisionproducts.com") by vger.kernel.org with ESMTP
	id S1751388AbWHIVwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 17:52:42 -0400
User-Agent: Microsoft-Entourage/11.2.4.060510
Date: Wed, 09 Aug 2006 14:52:41 -0700
Subject: Upgrading kernel across multiple machines
From: Brian McGrew <brian@visionpro.com>
To: <linux-kernel@vger.kernel.org>
Message-ID: <C0FFA739.8986%brian@visionpro.com>
Thread-Topic: Upgrading kernel across multiple machines
Thread-Index: Aca7/iMBYcw2rCfxEdu24AAKlbl8Ig==
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm using a Dell PE1800 and I've built a new 2.6.16.16 kernel on the machine
that works fine.  However, if I tar up /lib/modules/2.6.16.16 and /boot and
move it onto another Dell PE1800 running the exact same software (FC3/Stock
install) the new kernel doesn't boot.

On machine #1 life is good but moving it to machine #2, I get

/lib/ata_piix.ko: -l unknown symbol in module.

What am I missing?  Someone help please, I'm in a major time crunch!

Thanks!

:b!

-- 
Brian McGrew    { brian@visionpro.com || brian@doubledimenison.com }

> GUACOMOL: Vegetarian Roadkill!

