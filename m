Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135618AbREIBGv>; Tue, 8 May 2001 21:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135681AbREIBGl>; Tue, 8 May 2001 21:06:41 -0400
Received: from iris.services.ou.edu ([129.15.2.125]:46985 "EHLO
	iris.services.ou.edu") by vger.kernel.org with ESMTP
	id <S135618AbREIBGg>; Tue, 8 May 2001 21:06:36 -0400
Date: Mon, 07 May 2001 19:54:10 -0500
From: Sean Jones <sjones@ossm.edu>
Subject: Re: SPARC include problem
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <3AF743B2.5AC40466@ossm.edu>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-ac5 i586)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
In-Reply-To: <3AF71B1F.56FFCA16@ossm.edu>
 <15095.10082.285131.289903@pizda.ninka.net> <3AF72F44.27D752D3@ossm.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Jones wrote:
> 
> "David S. Miller" wrote:
> >
> > Sean Jones writes:
> >  > In compiling 2.4.4-ac5 for my SPARCStation 20, I had an error in the
> >  > compile resulting from the inability to find a hw_irq.h in the
> >  > include/asm directory. Do you know where I may be able to find such a
> >  > file?
> >
> > How did you find this problem if the build couldn't find the
> > "bzImage" rule? :-)
> >
> > Later,
> > David S. Miller
> > davem@redhat.com
> 
> I found it by kicking the make stuff around one more time after I sent
> that e-mail.
> 
> Sean
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
