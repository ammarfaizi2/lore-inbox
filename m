Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265002AbTANSzJ>; Tue, 14 Jan 2003 13:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265051AbTANSzJ>; Tue, 14 Jan 2003 13:55:09 -0500
Received: from vdp080.ath02.cas.hol.gr ([195.97.117.81]:34944 "EHLO
	pfn1.pefnos") by vger.kernel.org with ESMTP id <S265002AbTANSyQ>;
	Tue, 14 Jan 2003 13:54:16 -0500
Content-Type: text/plain; charset=US-ASCII
From: "P. Christeas" <p_christ@hol.gr>
To: Ducrot Bruno <poup@poupinou.org>, Pavel Machek <pavel@suse.cz>
Subject: Re: [ACPI] acpi_wakeup fixes: Patch?
Date: Tue, 14 Jan 2003 19:56:23 +0200
User-Agent: KMail/1.4.3
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20021217202142.GB1012@poup.poupinou.org>
In-Reply-To: <20021217202142.GB1012@poup.poupinou.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301141956.23716.p_christ@hol.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems you have been trying to correct the acpi_wakeup code (back at 17 
Dec). Has that been merged to Linus' tree?

I got 2.5.58 today, acpi_wakeup.S is still dated 16 Dec and that patch 
regarding the location of the wakeup asm code (see the '2.5.51: sleep 
broken') has not reached me through Linus' patches.

