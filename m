Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315614AbSECJLX>; Fri, 3 May 2002 05:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315615AbSECJLW>; Fri, 3 May 2002 05:11:22 -0400
Received: from ns.suse.de ([213.95.15.193]:54021 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S315614AbSECJLU>;
	Fri, 3 May 2002 05:11:20 -0400
Date: Fri, 3 May 2002 11:11:16 +0200
From: Dave Jones <davej@suse.de>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Treeve Jelbert <treeve01@pi.be>, linux-kernel@vger.kernel.org
Subject: Re: BUG - linux-2.5.13/arch/i386/kernel - bluesmoke.c
Message-ID: <20020503111115.C23381@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
	Treeve Jelbert <treeve01@pi.be>, linux-kernel@vger.kernel.org
In-Reply-To: <200205030959.52486.treeve01@pi.be> <Pine.LNX.4.44.0205030944180.12156-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2002 at 09:45:20AM +0200, Zwane Mwaikambo wrote:
 > You need CONFIG_X86_LOCAL_APIC, a proper fix is currently in 2.5-dj 
 > pending a merge.

+ Brian Gerst's changes, + some more bending of my own.
I'll put up another patch soon, if that goes ok, I'll push the bluesmoke
bits to Linus in the next round.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
