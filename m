Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315265AbSD3XVv>; Tue, 30 Apr 2002 19:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315266AbSD3XVu>; Tue, 30 Apr 2002 19:21:50 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4873 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315265AbSD3XVu>; Tue, 30 Apr 2002 19:21:50 -0400
Subject: Re: romfx XIP patch
To: mschulz@rose.man.poznan.pl (Michal Schulz)
Date: Wed, 1 May 2002 00:40:01 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.20.0204301648450.11086-101000@rose.man.poznan.pl> from "Michal Schulz" at Apr 30, 2002 04:56:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E172hE1-0000fL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Flash-ROM. Because the machine doesn't have too much memory, I have fixed
> 2.2.18 kernel, so that it keeps all unwritable sections if ROM and that's
> the place where they're executed for. Thanks to that I have spared about
> 500KB of memory.

(I'd be interested in these patches too)

