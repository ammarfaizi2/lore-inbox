Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313898AbSFNT4y>; Fri, 14 Jun 2002 15:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314082AbSFNT4x>; Fri, 14 Jun 2002 15:56:53 -0400
Received: from ns.suse.de ([213.95.15.193]:58641 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S313898AbSFNT4x>;
	Fri, 14 Jun 2002 15:56:53 -0400
Date: Fri, 14 Jun 2002 21:56:54 +0200
From: Dave Jones <davej@suse.de>
To: john stultz <johnstul@us.ibm.com>
Cc: marcelo@conectiva.com.br, lkml <linux-kernel@vger.kernel.org>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [Patch] tsc-disable_A5
Message-ID: <20020614215654.V16772@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	john stultz <johnstul@us.ibm.com>, marcelo@conectiva.com.br,
	lkml <linux-kernel@vger.kernel.org>,
	"Martin  J. Bligh" <Martin.Bligh@us.ibm.com>
In-Reply-To: <1024079726.29929.131.camel@cog> <20020614205751.U16772@suse.de> <1024081458.29928.148.camel@cog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2002 at 12:04:18PM -0700, john stultz wrote:

 > .config that looked like:
 > 
 > CONFIG_X86_TSC=y
 > ...
 > # CONFIG_X86_TSC is not set
 > So I assumed CONFIG_X86_TSC would still hold. Am I wrong, or is there
 > another way to do this?

Ugh, I hadn't realised the .config generation was so primitive.
That's quite unfortunate. That needs fixing at some point.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
