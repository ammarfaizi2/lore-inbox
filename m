Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262982AbVF3OiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262982AbVF3OiV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 10:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262981AbVF3OiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 10:38:21 -0400
Received: from mail.harcroschem.com ([208.188.194.242]:16135 "EHLO
	kcdc1.harcros.com") by vger.kernel.org with ESMTP id S262982AbVF3OiP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 10:38:15 -0400
Message-ID: <D9A1161581BD7541BC59D143B4A06294021FAAA4@KCDC1>
From: "Hodle, Brian" <BHodle@harcroschem.com>
To: "'sean.bruno@dsl-only.net'" <sean.bruno@dsl-only.net>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: RE: ASUS K8N-DL Beta AKA PROBLEM: Devices behindPCO Express-t
	o-PCI bridge not mapped
Date: Thu, 30 Jun 2005 09:33:25 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guys,

I actually disabled the AGP bus entireley to prevent the mapping of a 64mb 
aperature when I recompiled. So did the BIOS update help you gents at all?
The 
only thing it allows me to do now is Enable the ACPI SRAT and ACPI APIC
without 
the computer hanging. Although now, I am having USB bus IRQ conflicts and
the 
MB still won't correctly allocate resources.

Cheers,

-Brian



