Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbTHYLMS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 07:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbTHYLMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 07:12:18 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:46750 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S261704AbTHYLMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 07:12:14 -0400
Date: Mon, 25 Aug 2003 08:07:45 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Richard Russon <ntfs@flatcap.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>,
       Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [PATCH] NTFS bugfix, buildfix for 2.4.22-rc4
Message-ID: <Pine.LNX.4.55L.0308250806530.8867@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 25 Aug 2003, Richard Russon wrote:

> Hi Marcelo,
>
> This patch:
>   Fixes all NTFS build warnings
>   Fixes some broken macros (debug build only)
>
> Gerardo Exequiel Pozzi sent you a patch to fix the NTFS build warnings.
> I have tested the patch and fixed a couple of broken macros he missed.
> Anton Altaparmakov has given the patch his seal of approval :-)
>
> Please can you apply the patch to 2.4.22-rc4

Nope, too late in 2.4.22 cycle.

It will be included in 2.4.23-pre, thanks.
