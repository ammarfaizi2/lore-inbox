Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287115AbSAVP04>; Tue, 22 Jan 2002 10:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287303AbSAVP0q>; Tue, 22 Jan 2002 10:26:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9221 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287115AbSAVP0f>;
	Tue, 22 Jan 2002 10:26:35 -0500
Message-ID: <3C4D84A8.A404CCFC@mandrakesoft.com>
Date: Tue, 22 Jan 2002 10:26:32 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.2-pre9fs7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>, bjornw@axis.com
Subject: Re: cris patches in 2.5.3-pre3.
In-Reply-To: <20020122151951.A16157@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> Some of the cris patches in pre3 seem to be going backwards.
> Is this intentional? Or just CVS weirdness ?

> -# $Id: Makefile,v 1.22 2001/10/01 14:42:38 bjornw Exp $
> +# $Id: Makefile,v 1.3 2002/01/21 15:21:23 bjornw Exp $

from 2001 -> 2002

> -/* $Id: head.S,v 1.8 2001/10/03 17:15:15 bjornw Exp $
> +/* $Id: head.S,v 1.2 2001/12/18 13:35:12 bjornw Exp $

from october -> december

looks ok to me, do I need more caffeine?  :)

	Jeff


-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
