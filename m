Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288675AbSAQNSC>; Thu, 17 Jan 2002 08:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288689AbSAQNRy>; Thu, 17 Jan 2002 08:17:54 -0500
Received: from ns.suse.de ([213.95.15.193]:50186 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288675AbSAQNRZ>;
	Thu, 17 Jan 2002 08:17:25 -0500
Date: Thu, 17 Jan 2002 14:17:20 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Jeremy Freeman <jfreeman@sporg.com>, <linux-kernel@vger.kernel.org>
Subject: Re: XP PCI Contamination, GURR (Re: Care?)
In-Reply-To: <Pine.LNX.4.10.10201170438020.30663-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.33.0201171416200.22662-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2002, Andre Hedrick wrote:

> It appears the folks up in redmond have succeeded in having the BIOS
> people default disable PCI resources.  Since XP will reject, or assume a
> device is in use should the BAR's be allocated, the various archs may need
> to have a broader setup table or a more generic ruleset.
> Any thoughts on how best to address good hardare, which the BIOS does not
> setup per redmond-rules.

Why do I have this sneaking suspicion that ACPI will play a part here.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

