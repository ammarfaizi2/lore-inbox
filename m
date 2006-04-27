Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbWD0PyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWD0PyE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 11:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965158AbWD0PyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 11:54:04 -0400
Received: from uproxy.gmail.com ([66.249.92.172]:63433 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965157AbWD0PyC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 11:54:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FvJ2HKPLEvgmNV92ufZwa3X11gup4xrDsg5E4T5gU2bN9C161qDC5AilpnZVpewt+Nrve8N/p/0JMh2q90UCuMeiyqOROSBhjJFp3Z+oiWsqkIKdj3a34DftOUKe7Swg72B3zWFdJmP4ix1kYYIEKS50Za5CU5LPvjiQbNv783c=
Message-ID: <b6c5339f0604270854k4ca4b2e0mc66ae6972a42b418@mail.gmail.com>
Date: Thu, 27 Apr 2006 11:54:00 -0400
From: "Bob Copeland" <me@bobcopeland.com>
To: "Denis Vlasenko" <vda@ilport.com.ua>
Subject: Re: C++ pushback
Cc: "Avi Kivity" <avi@argo.co.il>, "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Roman Kononov" <kononov195-far@yahoo.com>,
       "LKML Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <200604271756.30679.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060426034252.69467.qmail@web81908.mail.mud.yahoo.com>
	 <200604271655.48757.vda@ilport.com.ua> <4450D4E9.4050606@argo.co.il>
	 <200604271756.30679.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/06, Denis Vlasenko <vda@ilport.com.ua> wrote:
> On Thursday 27 April 2006 17:27, Avi Kivity wrote:
> > > Where do you see goto-heavy code in kernel?
> > >
> > >
> >
> > [avi@cleopatra linux]$ grep -rw goto . | wc -l
> > 37448
> >
> > Repeat without 'wc' to get a detailed listing.
>
> In 1999 Dave 'Barc0de' Jones, Paranoid wierdo noize making geek,
> wrote this:
>
> http://www.uwsg.iu.edu/hypermail/linux/kernel/9901.2/0939.html
>
> I failed to find a link, but in 2004 Dave Jones, a well-known
> kernel hacker, wrote something like "Wow, it's fun to read
> my own old mail, how naive I was back then :)"

Possibly:

http://marc.theaimsgroup.com/?l=linux-kernel&m=104246373424112

-Bob
