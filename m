Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265556AbTFWWww (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 18:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265555AbTFWWvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 18:51:46 -0400
Received: from smtp4.knology.net ([24.214.63.227]:28805 "HELO
	smtp4.knology.net") by vger.kernel.org with SMTP id S265550AbTFWWtY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 18:49:24 -0400
Subject: RE: 2.5.72 doesn't boot
From: John Shillinglaw <linuxtech@knology.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <334DD5C2ADAB9245B60F213F49C5EBCD05D551C5@axcs03.cos.agilent.com>
References: <334DD5C2ADAB9245B60F213F49C5EBCD05D551C5@axcs03.cos.agilent.com>
Content-Type: text/plain
Organization: 
Message-Id: <1056409411.5888.7.camel@Aragorn>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jun 2003 19:03:31 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You need to turn on the options within the input/char driver? menu
within menuconfig to turn on the console. I believe there are two
options you need to say yes to. Someone with clearer memory can post the
exact ones.

John
On Mon, 2003-06-23 at 13:31, yiding_wang@agilent.com wrote:
> I got same issue on 2.5.70 and 2.5.71 and still waiting form some help.
> 
> Eddie
> 
> > -----Original Message-----
> > From: Bart SCHELSTRAETE [mailto:Bart.SCHELSTRAETE@dhl.com]
> > Sent: Sunday, June 22, 2003 11:06 AM
> > To: linux-kernel@vger.kernel.org
> > Subject: 2.5.72 doesn't boot
> > 
> > 
> > HEllo,
> > 
> > Today I tried kernel 2.5.72. And it compiled without any 
> > problems. (on a 
> > i686 - PIV)
> > But when I'm trying to boot from that kernel, it stops just 
> > after the line
> >          'uncompressing .................. ok now booting'
> > 
> > I tried to compile the kernel as a i386, pentium classic , 
> > and a pentium 
> > pro, but it always gives the same results.
> > Anybody has an idea what I did wrong?
> > 
> > 
> > rgrds,
> >        Bart
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe 
> > linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

