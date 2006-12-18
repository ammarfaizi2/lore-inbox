Return-Path: <linux-kernel-owner+w=401wt.eu-S1752334AbWLRDUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334AbWLRDUI (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 22:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752364AbWLRDUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 22:20:08 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4205 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752334AbWLRDUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 22:20:06 -0500
Date: Mon, 18 Dec 2006 04:20:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, davem@davemloft.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sparclinux@vger.kernel.org
Subject: Re: 2.6.19 (current from git) on SPARC64: Can't mount /
Message-ID: <20061218032003.GU10316@stusta.de>
References: <200612131856.kBDIuk8U028993@laptop13.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612131856.kBDIuk8U028993@laptop13.inf.utfsm.cl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2006 at 03:56:46PM -0300, Horst H. von Brand wrote:
> I've been running kernel du jour straight from git on my SPARC Ultra 1 for
> some time now on Aurora Corona (Fedora relative, development branch). For a
> few days now 2.6.19 panics on boot, it can't mount /. 2.6.19 worked fine,
> as does 2.6.19.1 (Aurora changed gcc, mkinitrd, ... in between, so I had to
> rebuild a kernel to check if the problem lay elsewhere). Unpacking the
> initrds for 2.6.19 and 2.6.19.1 shows the same (nash script) /init and the
> same modules in both (ext3 + jbd, scsi_mod, sd_mod, esp, others).
> 
> I'm stumped. Any clue?

Is this issue still present in the latest -git?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

