Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287396AbSACRsy>; Thu, 3 Jan 2002 12:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287388AbSACRse>; Thu, 3 Jan 2002 12:48:34 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44552 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287355AbSACRsY>; Thu, 3 Jan 2002 12:48:24 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Dual athlon XP 1800 problems
Date: 3 Jan 2002 09:48:15 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a125gv$l3b$1@cesium.transmeta.com>
In-Reply-To: <3C311B00.FFB58648@get2chip.com> <20020101032335.A11129@suse.de> <1009868304.27412.2.camel@zaphod> <20020103165321.GA737@bombe.modem.informatik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020103165321.GA737@bombe.modem.informatik.tu-muenchen.de>
By author:    Andreas Bombe <bombe@informatik.tu-muenchen.de>
In newsgroup: linux.dev.kernel
> 
> The identification string is written by the BIOS.  Yours didn't know
> about XPs so it misidentified them as MPs.  Upgrade your BIOS if this
> bugs you.
> 
> If ID string contradicts what you think you bought, don't trust the ID
> string.
> 

This seems very odd.  I thought in Athlon processors the ID string
came from the *CPU* (via CPUID), not the BIOS...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
