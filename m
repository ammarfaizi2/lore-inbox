Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265666AbRFWIV0>; Sat, 23 Jun 2001 04:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265667AbRFWIVQ>; Sat, 23 Jun 2001 04:21:16 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:9232 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265666AbRFWIUz>; Sat, 23 Jun 2001 04:20:55 -0400
Subject: Re: ACPI + Promise IDE = disk corruption :-(((
To: andrew.grover@intel.com (Grover, Andrew)
Date: Sat, 23 Jun 2001 09:20:20 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk ('Alan Cox'), proski@gnu.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDEEF@orsmsx35.jf.intel.com> from "Grover, Andrew" at Jun 22, 2001 05:30:19 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15DieS-0004x1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's just *one* issue that has generated all the disk corruption reports.
> Putting the processor into the C3 power state, in combination with bus
> mastering. This is disabled in the most recent release. I'd love to fix this
> one, but if it were easy, it'd be fixed by now. Maybe you can shed some
> light - if you're willing, let me know and I'll describe the problem in
> greater detail.

By all means. I doubt I can help much on that issue but I can at least think
about it

> Could these discussions be opened up to a wider readership? Perhaps you
> could use linux-pm-devel@sourceforge.net, or
> acpi@phobos.fachschaften.tu-muenchen.de?

I have enough mail without reading those lists too. All I am talking about
here is parsing the irq routing and apic tables. 

