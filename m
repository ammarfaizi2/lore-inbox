Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbTBFTdN>; Thu, 6 Feb 2003 14:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267573AbTBFTdM>; Thu, 6 Feb 2003 14:33:12 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:53192 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP
	id <S261594AbTBFTdM>; Thu, 6 Feb 2003 14:33:12 -0500
Date: Fri, 07 Feb 2003 08:44:08 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [ACPI] Re: [PATCH] s4bios for 2.5.59 + apci-20030123
In-reply-to: <20030206153757.GB19350@atrey.karlin.mff.cuni.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Grover, Andrew" <andrew.grover@intel.com>, ducrot@poupinou.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI List <acpi-devel@lists.sourceforge.net>
Message-id: <1044560648.1700.17.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <F760B14C9561B941B89469F59BA3A847137FFE@orsmsx401.jf.intel.com>
 <20030204221003.GA250@elf.ucw.cz>
 <1044477704.1648.19.camel@laptop-linux.cunninghams>
 <20030206153757.GB19350@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-07 at 04:37, Pavel Machek wrote:

> No, no. It has to be exactly the same kernel, otherwise you get a nice
> crash (if you are lucky) and ugly data corruption (when you are not);
> there's check to prevent that and panic, however.
> 
> That's why I call S4bios more foolproof.

Oh of course; I'm with you. If you're running a different kernel, you
must have had an entirely different context when you suspended. Humble
apologies; I was only thinking about whether the image would
successfully load, not the difference in contents.

Regards,

Nigel

