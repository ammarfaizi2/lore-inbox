Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267529AbTAHPN3>; Wed, 8 Jan 2003 10:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267819AbTAHPN3>; Wed, 8 Jan 2003 10:13:29 -0500
Received: from port5.ds1-sby.adsl.cybercity.dk ([212.242.169.198]:61051 "EHLO
	trider-g7.fabbione.net") by vger.kernel.org with ESMTP
	id <S267529AbTAHPN2>; Wed, 8 Jan 2003 10:13:28 -0500
Date: Wed, 8 Jan 2003 16:22:07 +0100 (CET)
From: Fabio Massimo Di Nitto <fabbione@fabbione.net>
To: Wichert Akkerman <wichert@wiggy.net>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: ipv6 stack seems to forget to send ACKs
In-Reply-To: <20030108130850.GQ22951@wiggy.net>
Message-ID: <Pine.LNX.4.51.0301081616230.6523@trider-g7.ext.fabbione.net>
References: <20030108130850.GQ22951@wiggy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Wed, 8 Jan 2003, Wichert Akkerman wrote:

> tornado.wiggy.net is my client running Linux 2.4.19 (unpatched, UP machine),
> and 2001:968:1::2 is the icecast server running Linux 2.4.20-rc2-ac3 (SMP).
> If you want to test the stream yourself, please stream from
> http://ipv6.lkml.org:8000/difm .
>

I have no problem to stream from there. kernel-source-2.4.19 here. several
tunnels in the middle and different brand of routers...
anyway Im farly sure that the xmms patch is not the problem. We have been
testing it for more than 6 months now (for inclusion in debian, we are
not the upstream) and yes we hit a similar problems with one icecast
server but at that time we didn't care too much since it was basically at
the first tests round. I will see if i can get it up and running again
(it is not under my control) and investigate a bit more into it.

Thanks
Fabio
