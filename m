Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291745AbSCIABF>; Fri, 8 Mar 2002 19:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291717AbSCIAA4>; Fri, 8 Mar 2002 19:00:56 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20743 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291620AbSCIAAs>; Fri, 8 Mar 2002 19:00:48 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [Lse-tech] Re: [RFC] modularization of i386 setup_arch and mem_init in 2.4.18
Date: 8 Mar 2002 16:00:11 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a6bjab$9v3$1@cesium.transmeta.com>
In-Reply-To: <200203082108.g28L8I504672@w-gaughen.des.beaverton.ibm.com> <20020308223330.A15106@suse.de> <40480000.1015624741@flay> <20020308231609.C15106@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020308231609.C15106@suse.de>
By author:    Dave Jones <davej@suse.de>
In newsgroup: linux.dev.kernel
>
> On Fri, Mar 08, 2002 at 01:59:01PM -0800, Martin J. Bligh wrote:
>  
>  > It would be nice to see a "blessing in principle" from Marcelo and
>  > Linus before we / you start spending lots of time on this.
> 
>  When I first brought it up with hpa & Linus, I only got back
>  a reply from hpa. Whether Linus was in "I want to think about this"
>  mode or just random-drop I don't know, but I agree it's worth
>  making sure theres some degree of acceptance before doing such
>  a large change.
> 

It seems like it's the "obviously right thing" to do.  So far x86 (a
CPU architecture) has pretty much implied PC (a system architecuture),
since building a PC was the *only* reason to use x86, but that's
changing quickly.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
