Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292320AbSCIBWZ>; Fri, 8 Mar 2002 20:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292293AbSCIBWQ>; Fri, 8 Mar 2002 20:22:16 -0500
Received: from ns.suse.de ([213.95.15.193]:56079 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292320AbSCIBWB>;
	Fri, 8 Mar 2002 20:22:01 -0500
Date: Sat, 9 Mar 2002 02:21:59 +0100
From: Dave Jones <davej@suse.de>
To: Josh Fryman <fryman@cc.gatech.edu>
Cc: Christer Weinigel <wingel@acolyte.hack.org>, gone@us.ibm.com,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [RFC] modularization of i386 setup_arch and mem_init in 2.4.18
Message-ID: <20020309022158.E15106@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Josh Fryman <fryman@cc.gatech.edu>,
	Christer Weinigel <wingel@acolyte.hack.org>, gone@us.ibm.com,
	linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
In-Reply-To: <200203082108.g28L8I504672@w-gaughen.des.beaverton.ibm.com> <20020308223330.A15106@suse.de> <20020308234811.3F003F5B@acolyte.hack.org> <20020308201518.533dc16a.fryman@cc.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020308201518.533dc16a.fryman@cc.gatech.edu>; from fryman@cc.gatech.edu on Fri, Mar 08, 2002 at 08:15:18PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2002 at 08:15:18PM -0500, Josh Fryman wrote:
 > excuse me for intruding a bit, but in the restructuring of kernel 2.5.x, is
 > there any notion of separating the build directories from the source 
 > directories?  if you're all hacking up the tree org anyway, this would be a
 > nice feature... (somewhat like gcc, i guess)

 Sounds like you want the shadow tree feature of kbuild-2.5
 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
