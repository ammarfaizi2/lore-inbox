Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267434AbUBROg6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 09:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267409AbUBROg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 09:36:58 -0500
Received: from smtp.terra.es ([213.4.129.129]:20202 "EHLO tsmtp8.mail.isp")
	by vger.kernel.org with ESMTP id S267434AbUBROg5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 09:36:57 -0500
Date: Wed, 18 Feb 2004 15:31:23 +0100
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Intel vs AMD x86-64
Message-Id: <20040218153123.2fa8ab42.diegocg@teleline.es>
In-Reply-To: <16435.14044.182718.134404@alkaid.it.uu.se>
References: <Pine.LNX.4.58.0402171739020.2686@home.osdl.org>
	<16435.14044.182718.134404@alkaid.it.uu.se>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 18 Feb 2004 10:56:44 +0100 Mikael Pettersson <mikpe@csd.uu.se> escribió:

> From what I can see from these docs, Intel's "IA-32e" is very very close
> to the natural combination of P4 with AMD64. No hyperlink stuff, but
> otherwise the same. The local APIC and performance counters should be
> exactly as in P4 :-)

Does that mean that the opteron-based distros will be able to run 
their x86-64 kernelspace/userspace in intel micros without modifications,
or only the userspace?


