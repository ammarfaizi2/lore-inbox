Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262464AbVG2HMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbVG2HMe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 03:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbVG2HMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 03:12:30 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:38047 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S262464AbVG2HMC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 03:12:02 -0400
Subject: Re: [PATCH 1/5] Add AIO event ring size tunable
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: "linux-aio kvack.org" <linux-aio@kvack.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1122569567.8278.12.camel@lade.trondhjem.org>
References: <1122565590.2019.80.camel@frecb000686>
	 <1122569567.8278.12.camel@lade.trondhjem.org>
Date: Fri, 29 Jul 2005 09:10:49 +0200
Message-Id: <1122621049.1989.99.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/07/2005 09:24:05,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 29/07/2005 09:24:09,
	Serialize complete at 29/07/2005 09:24:09
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-28 at 12:52 -0400, Trond Myklebust wrote:
> to den 28.07.2005 Klokka 17:46 (+0200) skreiv Sébastien Dugué:
> > 
> > 
> > 
> > 
> > 
> > 
> > 
> > ukjent vedlegg
> > (aiomaxevents)
> 
> Please don't post these patches as base-64 encoded anonymous
> attachments. It makes them very annoying to review.
> 
> In you must use attachments, use inlined ascii. Better still, don't use
> attachments at all, but just include the patch in the body of your
> email.
> 
> Cheers,
>   Trond
> 

  Argh, I usually use sylpheed to post patches, but forgot this
time. If someone wants me to resend, just ask.

  Sébastien.

-- 
------------------------------------------------------

  Sébastien Dugué                BULL/FREC:B1-247
  phone: (+33) 476 29 77 70      Bullcom: 229-7770

  mailto:sebastien.dugue@bull.net

  Linux POSIX AIO: http://www.bullopensource.org/posix
  
------------------------------------------------------

