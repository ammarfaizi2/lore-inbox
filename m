Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287425AbSBOHdI>; Fri, 15 Feb 2002 02:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287436AbSBOHc6>; Fri, 15 Feb 2002 02:32:58 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:785 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S287425AbSBOHco>; Fri, 15 Feb 2002 02:32:44 -0500
Message-Id: <200202150729.g1F7T2t25559@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: mark@staudinger.net, "Drew P. Vogel" <dvogel@intercarve.net>
Subject: Re: 2.4.12 on Pentium?
Date: Fri, 15 Feb 2002 09:29:04 -0200
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <200202141955.g1EJtwoX036235@mark.staudinger.net>
In-Reply-To: <200202141955.g1EJtwoX036235@mark.staudinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 February 2002 17:55, Mark Staudinger wrote:
> "Drew P. Vogel" <dvogel@intercarve.net> said:
> > On Thu, 14 Feb 2002, Mark Staudinger wrote:
> > >Is there any known problem with running kernel 2.4.12 on a P54/P55 CPU?
>
> I'm
>
> > >unable to get a 2.4.12 kernel to boot on a pentium class machine,
>
> regardless
>
> > >of what I choose for the "Processor Family" support in the config.
> > >
> > >A similar (if not identical) config of kernel 2.4.5 works just fine,
> > > even
>
> if
>
> > >compiled for 686/Celeron processor family.
> >
> > copy the .config from the 2.4.5 directory and do a 'make oldconfig' just
> > to be sure.
> >
> > --Drew Vogel
>
> Done.  Still the same symptom (reset during kernel load). I take it this
> isn't a known problem then?

Do the same with latest 2.4
--
vda
