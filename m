Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264024AbTE0Rrx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 13:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264030AbTE0RqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 13:46:07 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:2447 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264024AbTE0Rp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 13:45:26 -0400
Date: Tue, 27 May 2003 14:56:36 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Parag Warudkar <paragw@excite.com>
Cc: lkml <linux-kernel@vger.kernel.org>, dahinds@users.sourceforge.net
Subject: RE:Linux 2.4.21-rc4
In-Reply-To: <20030527150416.408A03CE6@xmxpita.excite.com>
Message-ID: <Pine.LNX.4.55L.0305271450140.756@freak.distro.conectiva>
References: <20030527150416.408A03CE6@xmxpita.excite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 May 2003, Parag Warudkar wrote:

>
> Marcelo,
>
> [Noting that there is no changelog pertaining to PCMCIA in rc4] PCMCIA is still not usable for me with stock 2.4.21-rc4 kernel.
> I can reproduce a complete hang (no response whatsoever) with rc3 everytime I boot with the PCMCIA service enabled.
>
> I am patching it with latest ACPI patch from Sourceforge, but turning ACPI off doesn't make a difference.
>
> Of course I can try vendor kernels or -ac, but is PCMCIA something with a priority low enough for such a major bug to be ignored?
>
> (See my earlier post [2.4.21-rc3 PCMCIA serial_cs.c Reproducible Hang] - for complete details)
>
> If anyone is interested I am ready to provide all details and experiment further.

David,

Can you take care of this one?

