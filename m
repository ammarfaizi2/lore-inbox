Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWGDTOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWGDTOa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 15:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWGDTOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 15:14:30 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:1670 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S932343AbWGDTO3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 15:14:29 -0400
Date: Tue, 4 Jul 2006 21:14:11 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Dave Jones <davej@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>
Subject: Re: [Ubuntu PATCH] Add Dothan frequency tables for speedstep
Message-ID: <20060704191411.GA9787@mail.muni.cz>
References: <44A98250.6060508@oracle.com> <20060703214403.GP14292@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060703214403.GP14292@redhat.com>
User-Agent: Mutt/1.4.1i
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xhejtman@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 05:44:03PM -0400, Dave Jones wrote:
> Yes it works great if your system is wired up to use VID#C,
> but what if it isn't ?  It's got a 1 in 4 chance of working,
> and what it'll do in the other 3 cases is anyones guess.
> 
> As there's no way to tell which VID is in use, the only
> option on these systems is to use either the acpi
> mode of this driver, or acpi-cpufreq instead.

Is this the same reason why this patch wasn't accepted in mainline?
http://fabrice.bellamy.club.fr/bdz.undervolt.2005.10.22.a.patch

-- 
Luká¹ Hejtmánek
