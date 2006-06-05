Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751120AbWFEOC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWFEOC0 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 10:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWFEOC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 10:02:26 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:31250 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751115AbWFEOCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 10:02:25 -0400
Date: Mon, 5 Jun 2006 16:02:26 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jeff@garzik.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linville@tuxdriver.com
Subject: Linux kernel and laws
Message-ID: <20060605140226.GR3955@stusta.de>
References: <20060604135011.decdc7c9.akpm@osdl.org> <20060605010636.GB17361@havoc.gtf.org> <20060605085451.GA26766@infradead.org> <20060605123304.GA6066@havoc.gtf.org> <1149511707.3111.57.camel@laptopd505.fenrus.org> <20060605125235.GB6066@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060605125235.GB6066@havoc.gtf.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2006 at 08:52:35AM -0400, Jeff Garzik wrote:
>...
> > Paying attention to proper reverse engineering is good. Being
> > overzealous is not.
> 
> Being overzealous about merging drivers without first checking the legal
> ramifications is a good way to torpedo Linux.
> 
> Far too many people have a careless "U.S.A. laws suck, merge it anyway"
> attitude.

Independent of this issue:

An interesting question is how to handle legal issues properly.

Where is the borderline for rejecting code due to legal issues?
Might not be 100% correct according to laws in the USA.
Might not be 100% correct according to laws in Germany.
Might not be 100% correct according to laws in Finland.
Might not be 100% correct according to laws in Norway.
Might not be 100% correct according to laws in Brasil.
Might not be 100% correct according to laws in Japan.
Might not be 100% correct according to laws in India.
Might not be 100% correct according to laws in Russia.
Might not be 100% correct according to laws in China.
Might not be 100% correct according to laws in Saudi Arabia.
Might not be 100% correct according to laws in Iran.

For me living in Germany, none of these laws except for the German one 
has any relevance.

I've never seen people on this list pointing to probable problems with 
Chinese laws although these laws are relevant for four times as many 
people as US laws.

If someone would state a submission to the kernel might have issues 
according to Chinese laws, or Iranian laws, or Russian laws, would this 
be enough for keeping code out of the kernel?

This might sound like a theoretical question, but e.g. considering that 
the kernel contains cryptography code it's a question that might have 
wide practical implications.

> 	Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

