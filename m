Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131176AbRAQJUl>; Wed, 17 Jan 2001 04:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131317AbRAQJUb>; Wed, 17 Jan 2001 04:20:31 -0500
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:11533 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S131176AbRAQJUU>; Wed, 17 Jan 2001 04:20:20 -0500
From: aprasad@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: "Sajeev" <sajeevm@vantel.net>
cc: linux-kernel@vger.kernel.org
Message-ID: <CA2569D7.003337AC.00@d73mta05.au.ibm.com>
Date: Wed, 17 Jan 2001 14:43:09 +0530
Subject: Re: Problems in 2.4 kernel
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sanjeev Wrote:
I am not able to mount my floppy drive. When I try to mount it gives me the
following error
'mount: /dev/fd0 has wrong major or minor number'
_____________________________________________________________
i think kernel is unable to find the driver for the filesystem type you are
trying to mount.
The supporting module is missing(if its compiled as module)or module path
is not correct

Regards,
Anil


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
