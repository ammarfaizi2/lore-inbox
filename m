Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262732AbVBYPnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262732AbVBYPnk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 10:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbVBYPnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 10:43:40 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:50636 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262732AbVBYPmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 10:42:40 -0500
From: Christian Borntraeger <linux-kernel@borntraeger.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Invalid module format in Fedora core2
Date: Fri, 25 Feb 2005 16:42:18 +0100
User-Agent: KMail/1.7.1
Cc: Payasam Manohar <pmanohar@lantana.cs.iitm.ernet.in>
References: <Pine.LNX.4.60.0502252056130.17145@lantana.cs.iitm.ernet.in>
In-Reply-To: <Pine.LNX.4.60.0502252056130.17145@lantana.cs.iitm.ernet.in>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502251642.19276.linux-kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Payasam Manohar wrote:
>   Hai all,
>    I tried to insert a sample module into Fedora core 2 , But it is
> giving an error message that " no module in the object"
> The same module was inserted successfully into Redhat linux 9.
>
> Is there any changes from RH 9 to Fedora Core 2 with respect to the
> module writing and insertion.
>
> Any small help  also welcome.

Well, the most important difference is probably the move from Linux kernel 
2.4 to Linux kernel 2.6.

See http://lwn.net/Articles/driver-porting/ for details how to change 
modules from 2.4 to 2.6 (If source code is available).

cheers 

Christian
