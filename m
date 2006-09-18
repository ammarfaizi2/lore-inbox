Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965634AbWIRKKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965634AbWIRKKy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 06:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965635AbWIRKKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 06:10:54 -0400
Received: from anubis.fi.muni.cz ([147.251.54.96]:14492 "EHLO
	anubis.fi.muni.cz") by vger.kernel.org with ESMTP id S965634AbWIRKKx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 06:10:53 -0400
Date: Mon, 18 Sep 2006 12:12:11 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Lukas Jelinek <info@kernel-api.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: System restart
Message-ID: <20060918101211.GP3051@mail.muni.cz>
References: <20060916213849.GJ3051@mail.muni.cz> <450C8243.60406@kernel-api.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <450C8243.60406@kernel-api.org>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2006 at 01:01:23AM +0200, Lukas Jelinek wrote:
> > after upgrading BIOS to the latest version on my Intel Core 2 Duo with
> > DP965LT board kernel is unable to restart system. (Kernel 2.6.18-rc6.) With
> > older BIOS the same kernel restarts OK. The last message printed on console
> > is: Restarting system and system hangs.
> > 
> > I wonder, why "machine restart" message does not appear.
> > 
> > I tried kernel parameter reboot=t reboot=f reboot=t,w,f nothing helps.
> > 
> 
> This is probably not a kernel problem but a BIOS-related one. Since only
> a few boards/BIOSes need specific fixups it looks like your new BIOS is
> buggy. Try to contact the BIOS vendor and report this problem.

However, I wonder why Windows restart machine OK. I've also tried to disable
ACPI before reboot but no success.

-- 
Luká¹ Hejtmánek
