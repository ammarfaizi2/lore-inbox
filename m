Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282967AbSANOZR>; Mon, 14 Jan 2002 09:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286692AbSANOYg>; Mon, 14 Jan 2002 09:24:36 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:43674 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S282967AbSANOY3>; Mon, 14 Jan 2002 09:24:29 -0500
Date: Mon, 14 Jan 2002 16:23:22 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Jim Studt <jim@federated.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with ServerWorks CNB20LE and lost interrupts
In-Reply-To: <Pine.GSO.3.96.1020114150024.16706C-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.33.0201141622120.9308-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, Maciej W. Rozycki wrote:

>  The "noapic" option should probably get removed -- it was meant as a
> debugging aid (as many of the "no*" options) at the early days of I/O APIC
> support, I believe...  Now the support is pretty stable.

Oooooh that will break a _lot_ of boxes! Otherwise i agree wholeheartedly.

Cheers,
	Zwane Mwaikambo


