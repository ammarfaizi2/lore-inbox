Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265549AbTFMVl7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 17:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265542AbTFMVkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 17:40:16 -0400
Received: from aneto.able.es ([212.97.163.22]:10172 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S265544AbTFMVhQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 17:37:16 -0400
Date: Fri, 13 Jun 2003 23:50:59 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.21 released
Message-ID: <20030613215059.GA2961@werewolf.able.es>
References: <200306131453.h5DErX47015940@hera.kernel.org> <20030613165628.GE28609@in-ws-001.cid-net.de> <20030613172226.GB9339@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030613172226.GB9339@merlin.emma.line.org>; from matthias.andree@gmx.de on Fri, Jun 13, 2003 at 19:22:26 +0200
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.13, Matthias Andree wrote:
> On Fri, 13 Jun 2003, Stefan Foerster wrote:
> 
> > * Marcelo Tosatti <marcelo@hera.kernel.org> wrote:
> > > final:
> > > 
> > > - 2.4.21-rc8 was released as 2.4.21 with no changes.
> > 
> > Can we expect the latest ACPI and aic7xxx stuff in 2.4.22-pre?
> 
> I'd add "XFS merge" to the list:
> 

I have many other, simpler things in my set:
- Fix for bad AT_PLATFORM on HT Xeons
- check_gcc for x86
- separate config option for PII (yes some still have that and does not hurt)
- CONFIG_NR_CPUS
- hfsplus driver (first will talk to maintainer if he cares...)

And a ton of possibly fixes I have collected over time, but someone would have
to review them.
Don't know if there is any chance to get them in, but...I will send to the list.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-rc8-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-1mdk))
