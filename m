Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264839AbSKRV06>; Mon, 18 Nov 2002 16:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264842AbSKRV06>; Mon, 18 Nov 2002 16:26:58 -0500
Received: from fep19-0.kolumbus.fi ([193.229.0.45]:35506 "EHLO
	fep19-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id <S264839AbSKRV06>; Mon, 18 Nov 2002 16:26:58 -0500
Date: Mon, 18 Nov 2002 23:33:58 +0200 (EET)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: linux-kernel@vger.kernel.org
cc: Gregoire Favre <greg@ulima.unil.ch>
Subject: Re: 2.5.48 and SCSI ?
In-Reply-To: <20021118203605.GC8357@ulima.unil.ch>
Message-ID: <Pine.LNX.4.44.0211182329020.736-100000@kai.makisara.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Gregoire Favre wrote:

> Hello,
>
> I have applied the patch sent today, but the kernel don't find my root
> (aic7xxx), what I got is:
>
I had the same problem with sym53c8xxx_2 when devfs was configured into
the kernel (but not mounted). Then I made a kernel with devfs disabled and
now this boots (and seems to work).

-- 
Kai

