Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbTFXQuw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 12:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbTFXQuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 12:50:52 -0400
Received: from msgbas2x.cos.agilent.com ([192.25.240.37]:50388 "EHLO
	msgbas2x.cos.agilent.com") by vger.kernel.org with ESMTP
	id S262192AbTFXQus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 12:50:48 -0400
Message-ID: <334DD5C2ADAB9245B60F213F49C5EBCD05D551CC@axcs03.cos.agilent.com>
From: yiding_wang@agilent.com
To: linuxtech@knology.net, linux-kernel@vger.kernel.org
Subject: RE: 2.5.72 doesn't boot
Date: Tue, 24 Jun 2003 11:04:32 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks John, I will try.

> -----Original Message-----
> From: John Shillinglaw [mailto:linuxtech@knology.net]
> Sent: Monday, June 23, 2003 4:04 PM
> To: linux-kernel@vger.kernel.org
> Subject: RE: 2.5.72 doesn't boot
> 
> 
> You need to turn on the options within the input/char driver? menu
> within menuconfig to turn on the console. I believe there are two
> options you need to say yes to. Someone with clearer memory 
> can post the
> exact ones.
> 
> John
> On Mon, 2003-06-23 at 13:31, yiding_wang@agilent.com wrote:
> > I got same issue on 2.5.70 and 2.5.71 and still waiting 
> form some help.
> > 
> > Eddie
> > 
> > > -----Original Message-----
> > > From: Bart SCHELSTRAETE [mailto:Bart.SCHELSTRAETE@dhl.com]
> > > Sent: Sunday, June 22, 2003 11:06 AM
> > > To: linux-kernel@vger.kernel.org
> > > Subject: 2.5.72 doesn't boot
> > > 
> > > 
> > > HEllo,
> > > 
> > > Today I tried kernel 2.5.72. And it compiled without any 
> > > problems. (on a 
> > > i686 - PIV)
> > > But when I'm trying to boot from that kernel, it stops just 
> > > after the line
> > >          'uncompressing .................. ok now booting'
> > > 
> > > I tried to compile the kernel as a i386, pentium classic , 
> > > and a pentium 
> > > pro, but it always gives the same results.
> > > Anybody has an idea what I did wrong?
> > > 
> > > 
> > > rgrds,
> > >        Bart
> > > 
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe 
> > > linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
