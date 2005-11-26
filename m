Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbVKZXqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbVKZXqU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 18:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbVKZXqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 18:46:20 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:7844 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1750783AbVKZXqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 18:46:20 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: David Brown <dmlb2000@gmail.com>
Subject: Re: linux-2.6.14.tar.bz2 permissions
Date: Sat, 26 Nov 2005 23:46:27 +0000
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <9c21eeae0511261352u33e32343wf50062ba3038ef06@mail.gmail.com> <9c21eeae0511261358v723419f2g853bddc839038996@mail.gmail.com>
In-Reply-To: <9c21eeae0511261358v723419f2g853bddc839038996@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511262346.27907.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 November 2005 21:58, David Brown wrote:
> I wasn't sure where to send this but here goes.
>
>  Seems that many of the source files in the linux-2.6.14.tar.bz2 have
> global read/write permissions.
>  Are the permissions supposed to be this way now?
>  If not, could this be fixed soon?
>  if so, could you point me to a url that explains why.

David, it'd probably help if you listed all of the affected files, then people 
can explain themselves and/or correct the permissions.

I personally think that your point is valid and security should be considered 
when packing the kernel sources. It might even be possible for Linus's 
tarball script to remove global write permissions.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
