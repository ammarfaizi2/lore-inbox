Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288531AbSADICf>; Fri, 4 Jan 2002 03:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288532AbSADIC0>; Fri, 4 Jan 2002 03:02:26 -0500
Received: from c88s124h4.upc.chello.no ([62.179.175.88]:48303 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S288534AbSADICU>; Fri, 4 Jan 2002 03:02:20 -0500
Subject: Re: The CURRENT macro
From: Terje Eggestad <terje.eggestad@scali.com>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: Jonathan Corbet <corbet@lwn.net>, Michael Zhu <mylinuxk@yahoo.ca>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020103195509.C26824@conectiva.com.br>
In-Reply-To: <20020103213455.34699.qmail@web14911.mail.yahoo.com>
	<20020103214839.9953.qmail@eklektix.com> 
	<20020103195509.C26824@conectiva.com.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 04 Jan 2002 09:03:01 +0100
Message-Id: <1010131382.4267.0.camel@eggis1>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-01-03 at 22:55, Arnaldo Carvalho de Melo wrote:

>  
> > A little grepping in the source would give you the answer there.  It's in
> > .../include/linux/blk.h.  
> 
> Or:
> 
> make tags
> vi -t CURRENT 
> 

Or 
make TAGS
emacs 
then in emacs: M-.


In either case make sure you do a make xconfig or another config to 
make sure tags are correct for your platform.


> 8)
> 
> - Arnaldo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


TJ

