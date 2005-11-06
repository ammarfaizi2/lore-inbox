Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbVKFQuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbVKFQuw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 11:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbVKFQuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 11:50:52 -0500
Received: from web34203.mail.mud.yahoo.com ([66.163.178.118]:39540 "HELO
	web34203.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932128AbVKFQuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 11:50:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=pQRiXJLiKfaPCCQ/kwYk3Houk2+Cie/sVVcmbu5El2rhkD9v3ZmsiLbUOGLYQNC2G4miQoLqgMS/m5bCeSyz/JmTlD3kJtlerbkoE96ceUAyNLXC+j1lxxAOdjFfIk7DxFMlSO7siL82od79XifBfEvPTtCjmyeaNWpLkxmGbHQ=  ;
Message-ID: <20051106165048.44786.qmail@web34203.mail.mud.yahoo.com>
Date: Sun, 6 Nov 2005 08:50:48 -0800 (PST)
From: John Carlson <carlsj@yahoo.com>
Subject: Re: New Linux Development Model
To: jerome lacoste <jerome.lacoste@gmail.com>,
       Edgar Hucek <hostmaster@ed-soft.at>
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <5a2cf1f60511060252t55e1a058o528700ea69826965@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- jerome lacoste <jerome.lacoste@gmail.com> wrote:

> On 11/5/05, Edgar Hucek <hostmaster@ed-soft.at>
> wrote:
> > Hi.
> >
> > Sorry for not posting my Name.
> >
> > Maybe you don't understand what i wanted to say or
> it's my bad english.
> > The ipw2200 driver was only an example. I had also
> problems with, vmware,
> > unionfs...
> > What i mean ist, that kernel developers make
> incompatible changes to the
> > header
> > files, change structures, interfaces and so on.
> Which makes the kernel
> > releases
> > incompatible.
> 
> I will ask you just one question: as a user, why did
> you want to
> upgrade your kernel?
> 
> On a server you want stability. So you don't
> upgrade. On a desktop,
> there are probably a bunch of out of kernel modules
> that will need
> upgrading with each new kernel modules. Just on the
> laptop I am using
> right now, I will have to upgrade the vmware bridge,
> nvidia driver,
> madwifi wireless driver, etc. And that's normal. The
> new development
> model didn't change that.
> 
> I avoid touching my kernel on boxes I do real work
> with. I do build a
> new kernel for test purposes and to give feedback if
> there's an issue.
> But most of the time I skip 2-3 versions before
> finding a very
> compelling reason to upgrade. And I stick with my
> distribution kernel
> as much as I can.
> 
> As for kernel/drivers developers, it's another
> story.
> 
> If it ain't broken, don't fix it.
> 
> Jerome
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Another method, the one I use, is to keep a small
drive with a minimum system on it to test/update the
kernel.  After updating the kernel and any modules
required on the test driver, its then a simple matter
to move them, if there are no problems, to my working
system.

Jack


John Carlson
<carlsj@yahoo.com>


		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
