Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262228AbTCWD0w>; Sat, 22 Mar 2003 22:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262236AbTCWD0w>; Sat, 22 Mar 2003 22:26:52 -0500
Received: from hiauly1.hia.nrc.ca ([132.246.100.193]:5638 "EHLO
	hiauly1.hia.nrc.ca") by vger.kernel.org with ESMTP
	id <S262228AbTCWD0w>; Sat, 22 Mar 2003 22:26:52 -0500
Message-Id: <200303230337.h2N3bhAC026836@hiauly1.hia.nrc.ca>
Subject: Re: [parisc-linux] Re: [Linux-ia64] Announce: modutils 2.4.24 is available
To: kaos@ocs.com.au (Keith Owens)
Date: Sat, 22 Mar 2003 22:37:43 -0500 (EST)
From: "John David Anglin" <dave@hiauly1.hia.nrc.ca>
Cc: willy@debian.org, linux-kernel@vger.kernel.org,
       parisc-linux@parisc-linux.org
In-Reply-To: <8755.1048390145@ocs3.intra.ocs.com.au> from "Keith Owens" at Mar 23, 2003 02:29:05 pm
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -#if defined(ARCH_ia64) || defined(ARCH_ppc64)
> +#if defined(ARCH_ia64) || defined(ARCH_ppc64) || defined(ARCH_hppa64)
>  #define HAS_FUNCTION_DESCRIPTORS
>  #endif

The 32-bit hppa port also has function descriptors.

Dave
-- 
J. David Anglin                                  dave.anglin@nrc-cnrc.gc.ca
National Research Council of Canada              (613) 990-0752 (FAX: 952-6602)
