Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbVJJRJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbVJJRJB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 13:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbVJJRJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 13:09:01 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:64028 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750973AbVJJRJA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 13:09:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=W9LfnRtErUHY5QGMM+rqhg8+CJ3Q0benrhwNt+msbc3qPO4ai5xTD0f6FbkzZ7DFOdmFTVgWM8WqKQyY4T5kJHH+A/CHo4rCrbKcgQaFs8IpT6LDGgY//Mz5DwYym7562M9t2CGDTYUbeJXAQv0PjshpWWpsFF/s5Q8Aq2fw650=
Message-ID: <460afdfa0510101008v3ad0b914oa2e557b112dde86b@mail.gmail.com>
Date: Mon, 10 Oct 2005 19:08:59 +0200
From: Luca <luca.foppiano@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: info for alc880
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, I have a audio card Intel HDA with chipset Realteck ALC880.
I have kernel 2.6.13.3 and I return this error when the pc start:

ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1b.0 to 64
hda_codec: Unknown model for ALC880, trying auto-probe from BIOS...
hda_codec: Cannot set up configuration from BIOS.  Using 3-stack mode...

This card is not supported?  I must patch the kernel?

Thanks everybody

Luca
