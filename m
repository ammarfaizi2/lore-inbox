Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbULULQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbULULQD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 06:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbULULQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 06:16:03 -0500
Received: from web60608.mail.yahoo.com ([216.109.119.82]:1208 "HELO
	web60608.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261732AbULULPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 06:15:53 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=zARjDUMYATN6tT4L7mfLsROjKPxj952MtvOhK6F3d6I9PSHzb4YLw7oKtuiiseNfsiHTB047p4Z9wGsvXvFgD/78ioI0jUna+9uJI9X76QtFPe4OK8jmLgJlASIEGFQdyKUv9vJYnc1UJTd08rc2HiCWGYnUBIVv7Jxk8vOYQFI=  ;
Message-ID: <20041221111552.34872.qmail@web60608.mail.yahoo.com>
Date: Tue, 21 Dec 2004 03:15:52 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: Re : Re: Error - Kernel panic - not syncing:VFS:unable to mount root fs on unknown block (0,0)
To: Margus Eha <margus.eha@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <f396da0804122102561d30d04e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I am already having linux kernel 2.4 series which is
working quite well. It also resides on the same root
partition. I do have IDE. 
  Should I reconfigure  kernel 2.6 with all types of
IDE support or is there any other way?

Thanks,
selva

--- Margus Eha <margus.eha@gmail.com> wrote:

> Seems you are missing ide.
> 
> Margus
> 
> 
> On Tue, 21 Dec 2004 02:34:54 -0800 (PST), selvakumar
> nagendran
> <kernelselva@yahoo.com> wrote:
> >   I installed the latest stable 2.6.9 kernel in my
> > system. When I rebooted the system with the kernel
> it
> > showed the following error.
> > 
> >      "Kernel panic - not syncing:VFS:unable to
> mount
> > root fs on unknown block (3,1)"
> > 
> >     What is the solution to get rid of this error?
> >     What is the measure to prevent such errors in
> the
> > future?
> >      I downloaded the kernel source tar ball from
> > kernel.org
> >     Can anyone help me regarding this?
> > 
> > Thanks,
> > selva
> > 
> > __________________________________
> > Do you Yahoo!?
> > All your favorites on one personal page – Try My
> Yahoo!
> > http://my.yahoo.com
> > -
> > To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
