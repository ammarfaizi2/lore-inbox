Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261541AbSKGThv>; Thu, 7 Nov 2002 14:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261542AbSKGThv>; Thu, 7 Nov 2002 14:37:51 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:25568 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S261541AbSKGThu> convert rfc822-to-8bit; Thu, 7 Nov 2002 14:37:50 -0500
Date: Thu, 7 Nov 2002 20:53:43 +0100
From: Heinz Diehl <hd@cavy.de>
To: Daniel Egger <degger@fhm.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IRQ Routing Conflict
Message-ID: <20021107195343.GA961@chiara.cavy.de>
Mail-Followup-To: Daniel Egger <degger@fhm.edu>,
	linux-kernel@vger.kernel.org
References: <20021101223645.GA216@chiara.cavy.de> <1036194155.14932.17.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1036194155.14932.17.camel@sonja.de.interearth.com>
Organization: private site in Mannheim/Germany
X-PGP-Key: Use PGP! Get my key at http://piggie:pages@www.cavy.de/hd.key
User-Agent: Mutt/1.5.1i (Linux 2.4.20-rc1aa1 i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Nov 02 2002, Daniel Egger wrote:

> Nov  1 16:10:20 nicole kernel: solo1: version v0.19 time 11:19:52 Apr 14 2002
> Nov  1 16:10:20 nicole kernel: PCI: Found IRQ 10 for device 00:13.0
> Nov  1 16:10:20 nicole kernel: IRQ routing conflict for 00:13.0, have irq 3, want irq 10
 
> This is also an Apollo/MVP3 chipset. Other than that the soundcard seems
> to work fine.

Just to mention it: my network card also works flawlessly with this
curious "irq routing conflict"....

Greetings, Heinz.
-- 
# Heinz Diehl, 68259 Mannheim, Germany
