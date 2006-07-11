Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWGKShg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWGKShg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 14:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWGKShg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 14:37:36 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:20941 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932080AbWGKShf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 14:37:35 -0400
Subject: Re: [klibc] klibc and what's the next step?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Olaf Hering <olh@suse.de>, Jeff Garzik <jeff@garzik.org>,
       Michael Tokarev <mjt@tls.msk.ru>, Roman Zippel <zippel@linux-m68k.org>,
       torvalds@osdl.org, klibc@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <44B3EC5A.1010100@zytor.com>
References: <klibc.200606251757.00@tazenda.hos.anvin.org>
	 <Pine.LNX.4.64.0606271316220.17704@scrub.home>
	 <20060711044834.GA11694@suse.de> <44B37D9D.8000505@tls.msk.ru>
	 <20060711112746.GA14059@suse.de> <44B3D0A0.7030409@zytor.com>
	 <20060711164040.GA16327@suse.de> <44B3DA77.50103@garzik.org>
	 <20060711171624.GA16554@suse.de> <44B3E7D5.8070100@zytor.com>
	 <20060711181552.GD16869@suse.de>  <44B3EC5A.1010100@zytor.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 11 Jul 2006 19:53:43 +0100
Message-Id: <1152644023.18028.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-07-11 am 11:22 -0700, ysgrifennodd H. Peter Anvin:
> You know how much code there is in glibc to make your /bin/ls still work?

A static linked pre libc 2.2 (thats libc not glibc) ls works fine today,
as does a 0.98.5 era built rogue binary

