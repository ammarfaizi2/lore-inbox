Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288638AbSAIAUt>; Tue, 8 Jan 2002 19:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288637AbSAIAUk>; Tue, 8 Jan 2002 19:20:40 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:62730 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288625AbSAIAUY>; Tue, 8 Jan 2002 19:20:24 -0500
Message-ID: <3C3B8B7F.54B1BD2B@zip.com.au>
Date: Tue, 08 Jan 2002 16:14:55 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Weinehall <tao@acc.umu.se>
CC: Greg KH <greg@kroah.com>, jtv <jtv@xs4all.nl>,
        Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: __FUNCTION__
In-Reply-To: <3C3B664B.3060103@intel.com> <20020108220149.GA15816@kroah.com> <20020108235649.A26154@xs4all.nl> <20020108231147.GA16313@kroah.com>, <20020108231147.GA16313@kroah.com>; <20020109003901.T5235@khan.acc.umu.se> <3C3B85E6.9634B180@zip.com.au>,
		<3C3B85E6.9634B180@zip.com.au>; from akpm@zip.com.au on Tue, Jan 08, 2002 at 03:51:02PM -0800 <20020109010424.U5235@khan.acc.umu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall wrote:
> 
> > in and changing the code is clearly not an option.  The only options
> 
> Huh? Most likely, your code is broken, rather than blaming the
> messenger, act properly upon the received message.
> 

When, and whether to do that should be my choice.

(And as the code in question was handling an entire
nation's 1-800 traffic, we stuck with the old compiler,
ta very much).

-
