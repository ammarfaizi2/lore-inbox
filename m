Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265843AbTAFDDP>; Sun, 5 Jan 2003 22:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265857AbTAFDDP>; Sun, 5 Jan 2003 22:03:15 -0500
Received: from [209.195.52.121] ([209.195.52.121]:46804 "HELO
	warden2b.diginsite.com") by vger.kernel.org with SMTP
	id <S265843AbTAFDDN>; Sun, 5 Jan 2003 22:03:13 -0500
From: David Lang <david.lang@digitalinsight.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Paul Rolland <rol@witbe.net>, linux-kernel@vger.kernel.org
Date: Sun, 5 Jan 2003 18:59:12 -0800 (PST)
Subject: Re: [2.5.54] Oops IDE-SCSI and failure AIC7xxx
In-Reply-To: <446440000.1041822490@aslan.scsiguy.com>
Message-ID: <Pine.LNX.4.44.0301051857210.23962-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, but it's the only error message I get and the AIX7xxx driver then
fails to initialize.

David Lang

On Sun, 5 Jan 2003, Justin T. Gibbs wrote:

> Date: Sun, 05 Jan 2003 20:08:10 -0700
> From: Justin T. Gibbs <gibbs@scsiguy.com>
> To: David Lang <david.lang@digitalinsight.com>
> Cc: Paul Rolland <rol@witbe.net>, linux-kernel@vger.kernel.org
> Subject: Re: [2.5.54] Oops IDE-SCSI and failure AIC7xxx
>
> > I get the same 'failed memory mapped' error (and the inability to run 2.5
> > kernels)
>
> The messages and the inability to run 2.5 kernels are not related.  The
> diagnostic prints and the driver falls back to using the "safe" PIO method.
>
> --
> Justin
>
