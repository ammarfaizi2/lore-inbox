Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263439AbTICPug (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 11:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263532AbTICPug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 11:50:36 -0400
Received: from mail.rdsor.ro ([193.231.238.10]:27582 "HELO mail.rdsor.ro")
	by vger.kernel.org with SMTP id S263439AbTICPu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 11:50:26 -0400
From: Balint Cristian <rezso@rdsor.ro>
Organization: Home
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-alpha@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Compiling latest 2.6 bk snapshot on Alpha
Date: Wed, 3 Sep 2003 18:44:43 -0400
User-Agent: KMail/1.5.2
References: <20030903143157.GA17699@localhost> <20030903150024.GA18306@localhost> <20030903151532.GH14376@lug-owl.de>
In-Reply-To: <20030903151532.GH14376@lug-owl.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309031844.43208.rezso@rdsor.ro>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If using RedHat-7.2 based thing on alpha or older you can use my own maintained RH rawhide for alpha:

ftp.rdsor.ro/pub/Linux/Distributions/AlphaLinux

There can find very latest gcc/binutils/glibc shaga, it must fit OK with any redhat for alphas.

I have no problem compiling latest kernel with tham.


Cristian


On Wednesday 03 September 2003 11:15, Jan-Benedict Glaw wrote:
> On Wed, 2003-09-03 11:00:24 -0400, Mathieu Chouquet-Stringer
> <mchouque@online.fr>
>
> wrote in message <20030903150024.GA18306@localhost>:
> > On Wed, Sep 03, 2003 at 04:40:31PM +0200, Marc Zyngier wrote:
> > > Please check your binutils version. Here is the one I use, with great
> > > success :
> > >
> > > maz@panther:/mnt/i386/linux-2.5$ alpha-linux-ld --version
> > > GNU ld version 2.13.90.0.18 20030121
> >
> > Mine is: GNU ld version 2.14.90.0.5 20030722 Debian GNU/Linux
>
> I've just started a compile run with exactly this ld and gcc-3.3.2
> 20030812. This may take a while (it's a 166MHz NoName...).
>
> Maybe you've simply created a too large kernel image. Have you compiled
> many features into the kernel (where modules would have worked also...)?
>
> MfG, JBG

-- 
Life in itself has no meaning. 
Life is an opportunity to create meaning.

              \|/ ____ \|/ 
              "@'/ .. \`@" 
              /_| \__/ |_\ 
                 \__U_/ 

