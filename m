Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262193AbREQWEE>; Thu, 17 May 2001 18:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262192AbREQWDy>; Thu, 17 May 2001 18:03:54 -0400
Received: from [195.180.174.83] ([195.180.174.83]:44928 "EHLO idun.neukum.org")
	by vger.kernel.org with ESMTP id <S262191AbREQWDi>;
	Thu, 17 May 2001 18:03:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
To: Tim Jansen <tim@tjansen.de>, t.sailer@alumni.ethz.ch
Subject: Re: LANANA: To Pending Device Number Registrants
Date: Fri, 18 May 2001 00:03:21 +0200
X-Mailer: KMail [version 1.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E150AgG-0004bb-00@the-village.bc.nu> <3B037304.1643693A@scs.ch> <01051718580902.00784@cookie>
In-Reply-To: <01051718580902.00784@cookie>
MIME-Version: 1.0
Message-Id: <01051800032102.01620@idun>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 17. May 2001 18:58, Tim Jansen wrote:
> On Thursday 17 May 2001 08:43, Thomas Sailer wrote:
> > Cheap USB devices (and sometimes even expensive ones)
> > do not have serial numbers or other unique identifiers.
> > Therefore some sort of topology based addressing scheme
> > has to be used in that case.
>
> No, there is another addressing scheme that can be for devices without
> serial number: the vendor and product ids. Most people do not have two
> devices of the same kind, so you often do not need the topology at all.

We need to handle the case, even if it is rare. Thus the code must be there. 
If it is there we may as well use it.

	Regards
		Oliver
