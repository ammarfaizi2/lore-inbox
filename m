Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263540AbUEPLNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUEPLNy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 07:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263557AbUEPLNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 07:13:54 -0400
Received: from pop.gmx.de ([213.165.64.20]:49594 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263540AbUEPLNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 07:13:53 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Daniele Venzano <webvenza@libero.it>
Subject: Re: problem with sis900
Date: Sun, 16 May 2004 13:21:49 +0200
User-Agent: KMail/1.6.2
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <1084300104.24569.8.camel@datacontrol> <200405151412.09233.dominik.karall@gmx.net> <20040515165641.GA1608@gateway.milesteg.arr>
In-Reply-To: <20040515165641.GA1608@gateway.milesteg.arr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405161321.50052.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 May 2004 18:56, Daniele Venzano wrote:
> On Sat, May 15, 2004 at 02:12:08PM +0200, Dominik Karall wrote:
> > But the patch did not apply, so I patched it by hand. To be sure that the
> > file was correctly patched by me, I attached it here.
>
> Applying the patch by hand, you forgot a piece, try to apply the patch
> to a clean, unmodified 2.6.6 sis900.c.

Same error messages again. I used an unmodified sis900.c from the 2.6.6 kernel 
and applied the diff successfully. But it does not help.

> Also, did you try to boot with the network cable plugged in ? The
> probing code has special case for transciever with link status on.
> If you want to try this, please use an unpatched kernel.

My network cable is plugged in all the time, connected to a switch.

> Thanks for testing.

Thanks for help!
