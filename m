Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265659AbSJXUpw>; Thu, 24 Oct 2002 16:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265661AbSJXUpw>; Thu, 24 Oct 2002 16:45:52 -0400
Received: from fmr01.intel.com ([192.55.52.18]:12257 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S265659AbSJXUpu>;
	Thu, 24 Oct 2002 16:45:50 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C7806CAC853@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'jitendra kulshreshtha'" <kulshres@usc.edu>, linux-kernel@vger.kernel.org
Subject: RE: Size Dependent sampling in Linux Kernel
Date: Thu, 24 Oct 2002 13:52:00 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Size Dependent Sampling algorithm defines new type of 
> sampling mechanism to sample the TCP flows. Can you please 
> let me know which are or directory should I start looking 
> into to find where can I change the kernel code to accomplish 
> this algorithm.

All the TCP code is at linux/net/ipv4, files tcp*.

G'd luck!

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]
