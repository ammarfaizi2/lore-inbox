Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317623AbSHCRit>; Sat, 3 Aug 2002 13:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317624AbSHCRit>; Sat, 3 Aug 2002 13:38:49 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:35345 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S317623AbSHCRit>; Sat, 3 Aug 2002 13:38:49 -0400
Date: Sat, 3 Aug 2002 19:42:00 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "Henning P. Schmiedehausen" <hps@intermeta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc5-ac1 and Intel SCB2 (OSB5) trouble
Message-ID: <20020803174200.GA3059@louise.pinerecords.com>
References: <aih3v2$11l$1@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aih3v2$11l$1@forge.intermeta.de>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 60 days, 8:10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.4.19 is also not able to set up the OSB5 chipset IDE controller in
> DMA mode. (Yes, I run latest BIOS from Intel)

This has been reported before, but for -pre10-ac1 IIRC.
2.4.19-pre2 works like a charm with OSB5.

T.
