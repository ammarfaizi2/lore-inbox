Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbTJRRoo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 13:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbTJRRoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 13:44:44 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:44790 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261749AbTJRRom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 13:44:42 -0400
Date: Sat, 18 Oct 2003 19:44:35 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add a config option for -Os compilation
Message-ID: <20031018174434.GJ12423@fs.tum.de>
References: <20031015225055.GS17986@fs.tum.de> <20031015161251.7de440ab.akpm@osdl.org> <20031015232440.GU17986@fs.tum.de> <20031015165205.0cc40606.akpm@osdl.org> <20031018102127.GE12423@fs.tum.de> <649730000.1066491920@[10.10.2.4]> <20031018102402.3576af6c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031018102402.3576af6c.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 18, 2003 at 10:24:02AM -0700, Andrew Morton wrote:
> "Martin J. Bligh" <mbligh@aracnet.com> wrote:
> >
> > Please don't - I benchmarked it a while ago, and it's definitely slower.
> 
> Alan said he generally found -Os to be faster...

Not exactly:
  http://www.ussg.iu.edu/hypermail/linux/kernel/0211.0/1513.html

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

