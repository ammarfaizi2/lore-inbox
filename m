Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317752AbSFLRyi>; Wed, 12 Jun 2002 13:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317753AbSFLRyh>; Wed, 12 Jun 2002 13:54:37 -0400
Received: from ns.suse.de ([213.95.15.193]:50193 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317752AbSFLRyg>;
	Wed, 12 Jun 2002 13:54:36 -0400
Date: Wed, 12 Jun 2002 19:54:36 +0200
From: Dave Jones <davej@suse.de>
To: Lance Larsh <llarsh@oracle.com>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [PATCH] arch/i386/kernel/bluesmoke.c, kernel 2.4.18
Message-ID: <20020612195436.I30645@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Lance Larsh <llarsh@oracle.com>, linux-kernel@vger.kernel.org,
	marcelo@conectiva.com.br
In-Reply-To: <Pine.LNX.4.33.0206121202150.22214-100000@llarsh-pc3.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2002 at 12:18:39PM -0700, Lance Larsh wrote:
 > In the i386 machine check exception handler, MSR_IA32_MCi_ADDR is not
 > output correctly.  Instead, MSR_IA32_MCi_STATUS is output a second time in
 > its place.

Should be already fixed in .19pre10

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
