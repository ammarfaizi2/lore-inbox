Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292293AbSCIBXH>; Fri, 8 Mar 2002 20:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292324AbSCIBWq>; Fri, 8 Mar 2002 20:22:46 -0500
Received: from acolyte.thorsen.se ([193.14.93.247]:51718 "HELO
	acolyte.hack.org") by vger.kernel.org with SMTP id <S292325AbSCIBWn>;
	Fri, 8 Mar 2002 20:22:43 -0500
From: Christer Weinigel <wingel@acolyte.hack.org>
To: fryman@cc.gatech.edu
Cc: davej@suse.de, gone@us.ibm.com, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
In-Reply-To: <20020308201518.533dc16a.fryman@cc.gatech.edu> (message from Josh
	Fryman on Fri, 8 Mar 2002 20:15:18 -0500)
Subject: Re: [RFC] modularization of i386 setup_arch and mem_init in 2.4.18
In-Reply-To: <200203082108.g28L8I504672@w-gaughen.des.beaverton.ibm.com>
	<20020308223330.A15106@suse.de>
	<20020308234811.3F003F5B@acolyte.hack.org> <20020308201518.533dc16a.fryman@cc.gatech.edu>
Message-Id: <20020309012240.84734F5B@acolyte.hack.org>
Date: Sat,  9 Mar 2002 02:22:40 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Fryman <fryman@cc.gatech.edu> wrote:
> excuse me for intruding a bit, but in the restructuring of kernel 2.5.x, is
> there any notion of separating the build directories from the source 
> directories?  if you're all hacking up the tree org anyway, this would be a
> nice feature... (somewhat like gcc, i guess)

<emulates Keith Owens>kbuild-2.5 will allow you to do that</>

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"
