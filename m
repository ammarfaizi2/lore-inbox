Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293606AbSBZWAY>; Tue, 26 Feb 2002 17:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293070AbSBZWAN>; Tue, 26 Feb 2002 17:00:13 -0500
Received: from tolkor.sgi.com ([192.48.180.13]:44674 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S293065AbSBZV77>;
	Tue, 26 Feb 2002 16:59:59 -0500
Subject: Re: Congrats Marcelo,
From: Steve Lord <lord@sgi.com>
To: Andreas Dilger <adilger@turbolabs.com>
Cc: "Dennis, Jim" <jdennis@snapserver.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <20020226140644.U12832@lynx.adilger.int>
In-Reply-To: <2D0AFEFEE711D611923E009027D39F2B153AD4@cdserv.meridian-data.com> 
	<20020226140644.U12832@lynx.adilger.int>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 26 Feb 2002 15:56:21 -0600
Message-Id: <1014760581.5993.159.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-02-26 at 15:06, Andreas Dilger wrote:
> On Feb 26, 2002  12:38 -0800, Dennis, Jim wrote:
> >  Now I need to know about the status of several unofficial patches:
> 
> While my word is by no means official, my general understanding is:
> 
> > 	XFS
> 
> Not for 2.4 - just too many changes to the core kernel code.

Someone has got to kill this assumption people have about XFS, it
makes much smaller changes than some things which have gone in,
the odd VM rewrite here and there to name some. Given that we now
have official EA system calls, the last chunk of stuff to resolve
is quota. This is being worked on with Jan Kara.

Steve


-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
