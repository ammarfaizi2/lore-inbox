Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266176AbRGDXox>; Wed, 4 Jul 2001 19:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266560AbRGDXoo>; Wed, 4 Jul 2001 19:44:44 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:64269 "EHLO
	mailout06.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S266176AbRGDXoZ>; Wed, 4 Jul 2001 19:44:25 -0400
Date: Thu, 5 Jul 2001 01:47:42 +0200 (CEST)
From: eduard.epi@t-online.de (Peter Bornemann)
To: Ronald Bultje <rbultje@ronald.bitfreak.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: >128 MB RAM stability problems (again)
In-Reply-To: <994279551.1116.0.camel@tux>
Message-ID: <Pine.LNX.4.33.0107050137500.4183-100000@eduard.t-online.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I have an Athlon 700 on a Asus/K7V motherboard with 256 MB PC 133
RAM. Never had any problem with this configuration. Before that, however,
there was an Pentium 120 with 64 MB RAM. This one used to crash during
kernel-compiles due to an overheated processor. Really funny. Later I got
kernel-panics during boot due to pagetable-corruption. This time it  was
bad RAM and went awayx after I changed one certain module. So I would almost
certainly relate Your problem to hardware failure.

Good success

Peter B

