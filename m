Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267105AbSLDVlH>; Wed, 4 Dec 2002 16:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267107AbSLDVlH>; Wed, 4 Dec 2002 16:41:07 -0500
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:55691 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S267105AbSLDVlG>; Wed, 4 Dec 2002 16:41:06 -0500
Date: Wed, 4 Dec 2002 14:41:17 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Dominique Arpin <dominique@espacecourbe.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: tridentfb.c error kernel 2.5.50
In-Reply-To: <34053.192.168.1.21.1038580281.squirrel@courriel.espacecourbe.com>
Message-ID: <Pine.LNX.4.33.0212041440500.1533-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>            i have some problem to compile the tridentfd driver on the
>            Kernel 2.5.50.I'm not sure this is the right mailinglist to submit my problem, but if u
> can help me.This problem doesnt appear on the 2.4.19 kernel. Did I miss something?

The framebuffer api has changed. A port of the driver will be done in the
next few releases.


