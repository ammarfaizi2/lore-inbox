Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289009AbSBIQJg>; Sat, 9 Feb 2002 11:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289012AbSBIQJY>; Sat, 9 Feb 2002 11:09:24 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55562 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289009AbSBIQJJ>; Sat, 9 Feb 2002 11:09:09 -0500
Subject: Re: [PATCH] Updated Fix For "make pdfdocs"
To: jferg3@swbell.net (Jason Ferguson)
Date: Sat, 9 Feb 2002 16:22:42 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
In-Reply-To: <1013267043.510.10.camel@werewolf> from "Jason Ferguson" at Feb 09, 2002 09:04:03 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ZaGw-0007QN-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> deviceiobook.tmpl. Problem is that include/asm-i386/io.h doesnt provide
> documentation, so trying to include said nonexistant documentation
> causes the whole process to fail.

What would be better would be to dig out and merge the documentation
patch for this file from an older 2.4.-ac. I'll go find out what
happened to it

