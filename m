Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315760AbSE3AMB>; Wed, 29 May 2002 20:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315805AbSE3AMA>; Wed, 29 May 2002 20:12:00 -0400
Received: from ns.suse.de ([213.95.15.193]:30225 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315760AbSE3AL7>;
	Wed, 29 May 2002 20:11:59 -0400
Date: Thu, 30 May 2002 02:11:59 +0200
From: Dave Jones <davej@suse.de>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        "J.A. Magallon" <jamagallon@able.es>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] intel-x86 model config cleanup
Message-ID: <20020530021159.B26821@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	"J.A. Magallon" <jamagallon@able.es>,
	Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <3CF53C34.2080300@mandrakesoft.com> <200205292205.g4TM5e8348005@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2002 at 06:05:40PM -0400, Albert D. Cahalan wrote:
 > 
 > This is still a mess. It's better to have one boolean
 > per processor, and order the processors by the year
 > in which they were most commonly sold.

The information hiding of irrelevant options was one of the
motivations behind that original patch. If I know I have
an AMD Athlon, showing me all the Intel CPUs just gets in the way.
A zillion options in a scrolly list is no better than what
we currently have imo.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
