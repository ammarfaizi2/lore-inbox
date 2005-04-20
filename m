Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbVDTMPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVDTMPD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 08:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVDTMPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 08:15:00 -0400
Received: from isilmar.linta.de ([213.239.214.66]:12693 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261571AbVDTMNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 08:13:14 -0400
Date: Wed, 20 Apr 2005 14:13:13 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Pavel Machek <pavel@suse.cz>
Cc: Thomas Renninger <trenn@suse.de>, Tony Lindgren <tony@atomide.com>,
       Frank Sorenson <frank@tuxrocks.com>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>,
       ML ACPI-devel <acpi-devel@lists.sourceforge.net>,
       Bodo Bauer <bb@suse.de>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Updated: Dynamic Tick version 050408-1 - C-state measures
Message-ID: <20050420121313.GF28491@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Pavel Machek <pavel@suse.cz>, Thomas Renninger <trenn@suse.de>,
	Tony Lindgren <tony@atomide.com>,
	Frank Sorenson <frank@tuxrocks.com>, linux-kernel@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Arjan van de Ven <arjan@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Andrea Arcangeli <andrea@suse.de>,
	George Anzinger <george@mvista.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	john stultz <johnstul@us.ibm.com>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Lee Revell <rlrevell@joe-job.com>,
	ML ACPI-devel <acpi-devel@lists.sourceforge.net>,
	Bodo Bauer <bb@suse.de>, Andi Kleen <ak@suse.de>
References: <42564584.4080606@tuxrocks.com> <42566C22.4040509@suse.de> <20050408115535.GI4477@atomide.com> <42651C38.6090807@suse.de> <20050419152723.GA9509@isilmar.linta.de> <42657222.5080601@suse.de> <20050420114433.GA28362@isilmar.linta.de> <20050420115739.GB16819@elf.ucw.cz> <20050420120102.GB28491@isilmar.linta.de> <20050420120846.GA21897@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050420120846.GA21897@elf.ucw.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 20, 2005 at 02:08:46PM +0200, Pavel Machek wrote:
> Like "ipw2x00 looses packets" if this happens too often?

See "PCI latency error if C3 enabled" on http://ipw2100.sf.net -- it causes
network instability, frequent firmware restarts.

	Dominik
