Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317386AbSFRL0u>; Tue, 18 Jun 2002 07:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317387AbSFRL0u>; Tue, 18 Jun 2002 07:26:50 -0400
Received: from [62.70.58.70] ([62.70.58.70]:21123 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S317386AbSFRL0t> convert rfc822-to-8bit;
	Tue, 18 Jun 2002 07:26:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Andrew Morton <akpm@zip.com.au>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [BUG] 2.4 VM sucks. Again
Date: Tue, 18 Jun 2002 13:26:27 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <200205241004.g4OA4Ul28364@mail.pronto.tv> <1572079531.1022225730@[10.10.2.3]> <3CEE954F.9CB99816@zip.com.au>
In-Reply-To: <3CEE954F.9CB99816@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206181326.27860.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Any plans to merge this into the main kernel, giving a choice
> > > (in config or /proc) to enable this?
> >
> > I don't think Andrew is ready to submit this yet ... before anything
> > gets merged back, it'd be very worthwhile testing the relative
> > performance of both solutions ... the more testers we have the
> > better ;-)
>
> Cripes no.  It's pretty experimental.  Andrea spotted a bug, too.  Fixed
> version is below.

Any more plans?
The patch has been working great for some time now, and I'd really like to see 
this in the official tree. Also - I guess this patch will eliminate any 
caching whatsoever, and therefore not really a good thing for file or web 
servers?

roy

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

