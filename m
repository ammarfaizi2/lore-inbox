Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311717AbSCNS31>; Thu, 14 Mar 2002 13:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311718AbSCNS3S>; Thu, 14 Mar 2002 13:29:18 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:33470 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S311717AbSCNS3I>; Thu, 14 Mar 2002 13:29:08 -0500
Date: Thu, 14 Mar 2002 11:01:54 -0700
Message-Id: <200203141801.g2EI1sK00638@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: pcmcia oops problem?
In-Reply-To: <m2henjruos.fsf@trasno.mitica>
In-Reply-To: <3C90BA11.40106@mandrakesoft.com>
	<m2henjruos.fsf@trasno.mitica>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juan Quintela writes:
> >>>>> "jeff" == Jeff Garzik <jgarzik@mandrakesoft.com> writes:
> 
> jeff> Can you describe the pcmcia oops problem in detail?
> jeff> What output do you get from a serial console?
> 
> Ok, trying to get better message now.

Can you:

- capture the Oops and decode with ksymoops
- make sure you always Cc: me on devfs-related problems (I nearly
  missed this one).

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
