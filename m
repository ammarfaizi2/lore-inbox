Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287568AbSAEHGU>; Sat, 5 Jan 2002 02:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287565AbSAEHGK>; Sat, 5 Jan 2002 02:06:10 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9478 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287568AbSAEHF4>; Sat, 5 Jan 2002 02:05:56 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ISA slot detection on PCI systems?
Date: 4 Jan 2002 23:05:34 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a168ju$pan$1@cesium.transmeta.com>
In-Reply-To: <3C338DCC.3020707@free.fr> <Pine.LNX.4.33.0201022349200.427-100000@Appserv.suse.de> <20020102174824.A21408@thyrsus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020102174824.A21408@thyrsus.com>
By author:    "Eric S. Raymond" <esr@thyrsus.com>
In newsgroup: linux.dev.kernel
> 
> But a setuid program *will not solve my problem*.
> 
> The person running the autoconfigurator is not and should not be doing so 
> as root.  Requiring the person to stop and sun sudo just so the 
> autoconfigurator can proceed is exactly the sort of pointless 
> obstacle we should *not* be putting in front of users!
> 

Could you please look up what a setuid program *IS*?

[Hint: a normal user can run them, and they get temporarily elevated
privilege for the duration of that process only.]

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
