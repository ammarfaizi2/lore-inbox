Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317904AbSFNKPX>; Fri, 14 Jun 2002 06:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317905AbSFNKPX>; Fri, 14 Jun 2002 06:15:23 -0400
Received: from [213.187.195.158] ([213.187.195.158]:31728 "EHLO
	kokeicha.ingate.se") by vger.kernel.org with ESMTP
	id <S317904AbSFNKPW>; Fri, 14 Jun 2002 06:15:22 -0400
To: Matthew Hall <matt@ecsc.co.uk>
Cc: Kernel <linux-kernel@vger.kernel.org>, jgarzik@mandrakesoft.com
Subject: Re: [PROBLEM] sundance on d-link dfe-580tx
In-Reply-To: <1023799395.3064.49.camel@smelly.dark.lan>
From: Marcus Sundberg <marcus@ingate.com>
Date: 14 Jun 2002 12:15:12 +0200
Message-ID: <vesn3q2mkv.fsf@inigo.ingate.se>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Hall <matt@ecsc.co.uk> writes:

> I have been testing the D-Link DFE-580TX Quad channel server card (4
> port nic), on kernel 2.4.18 with little success. 

[snip]

> I would appreciate being informed if there is a fix in a later
> version,or if any more debugging information is required I would be
> happy to oblige.

I have to define USE_IO_OPS to get the sundance driver to work with
the DFE-580TX. I haven't investigated why.

//Marcus
-- 
---------------------------------------+--------------------------
  Marcus Sundberg <marcus@ingate.com>  | Firewalls with SIP & NAT
 Firewall Developer, Ingate Systems AB |  http://www.ingate.com/
