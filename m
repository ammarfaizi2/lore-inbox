Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbRAYKzk>; Thu, 25 Jan 2001 05:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129444AbRAYKzb>; Thu, 25 Jan 2001 05:55:31 -0500
Received: from iq.sch.bme.hu ([152.66.226.168]:31300 "EHLO iq.rulez.org")
	by vger.kernel.org with ESMTP id <S129413AbRAYKzN>;
	Thu, 25 Jan 2001 05:55:13 -0500
Date: Thu, 25 Jan 2001 11:58:03 +0100 (CET)
From: Sasi Peter <sape@iq.rulez.org>
To: Anton Blanchard <anton@linuxcare.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <20010125212033.E14807@linuxcare.com>
Message-ID: <Pine.LNX.4.30.0101251157400.5377-100000@iq.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jan 2001, Anton Blanchard wrote:

> I have patches for samba to do sendfile. Making a tux module does not make
> sense to me, especially since we are nowhere near the limits of samba in
> userspace. Once userspace samba can run no faster, then we should think
> about other options.

Do you have it at a URL?

-- 
SaPE - Peter, Sasi - mailto:sape@sch.hu - http://sape.iq.rulez.org/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
