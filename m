Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265543AbSL1ICq>; Sat, 28 Dec 2002 03:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbSL1ICq>; Sat, 28 Dec 2002 03:02:46 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:50141 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S265543AbSL1ICq>; Sat, 28 Dec 2002 03:02:46 -0500
Date: Sat, 28 Dec 2002 03:11:02 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Richard Russon <ldm@flatcap.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.20 fs/partitions/Config.in
In-Reply-To: <1040360516.21624.14.camel@whiskey.something.uk.com>
Message-ID: <Pine.LNX.4.50L.0212280310320.30605-100000@freak.distro.conectiva>
References: <1040360516.21624.14.camel@whiskey.something.uk.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Dec 2002, Richard Russon wrote:

> Hi Marcelo,
>
> You have already accepted the new LDM Driver into 2.4 (thanks :-)
> but a little part of it got lost.
>
> This patch removes the "experimental" tag and dependency.
> (The new LDM Driver is not experimental).

The experimental tag is just a safety measure.
