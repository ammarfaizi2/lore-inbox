Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270659AbTGNSE2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 14:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270680AbTGNSE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 14:04:28 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:56011 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S270659AbTGNSE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 14:04:26 -0400
Date: Mon, 14 Jul 2003 20:19:05 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch balancing
Message-ID: <20030714181904.GP12104@fs.tum.de>
References: <D9B4591FDBACD411B01E00508BB33C1B01B1AEA8@mesadm.epl.prov-liege.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9B4591FDBACD411B01E00508BB33C1B01B1AEA8@mesadm.epl.prov-liege.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 10:14:38AM +0200, Frederick, Fabian wrote:

> Hi,

Hi Fabian,

> 	A simple question about patching : if I release a patch again vfs
> for instance.Do I send it against 2.4 branch or 2.5 ?
> Let's say it's get applied against 2.4 , when is it applied against 2.5 ?

You should send patches for both branches, if you don't send them at the 
same time send the 2.6 patch first.

> PS: When we come to 2.6pre, does 2.4 branch continues or is it 2.5 sequel
> only ?

The 2,4 branch will continue several years in bugfis-only mode similar 
to the 2.2 branch that is still alive.

> Regards,
> Fabian

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

