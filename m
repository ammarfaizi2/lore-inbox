Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUIOIB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUIOIB7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 04:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbUIOIB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 04:01:59 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:61457 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S263664AbUIOIB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 04:01:58 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Randy.Dunlap" <rddunlap@osdl.org>, "Roman Zippel" <zippel@linux-m68k.org>
Subject: Re: [PATCH] README (resend) - Explain new 2.6.xx.x version number
Date: Wed, 15 Sep 2004 11:01:21 +0300
User-Agent: KMail/1.5.4
Cc: "Daniel Andersen" <anddan@linux-user.net>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
References: <41476413.1060100@linux-user.net> <Pine.LNX.4.61.0409150255590.981@scrub.home> <1109.4.5.49.23.1095216021.squirrel@www.osdl.org>
In-Reply-To: <1109.4.5.49.23.1095216021.squirrel@www.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409151101.21715.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 September 2004 05:40, Randy.Dunlap wrote:
> > Hi,
> >
> > On Tue, 14 Sep 2004, Daniel Andersen wrote:
> >> This one ended up in the void last time without any comments.
> >
> > The funny thing is by the time people managed to apply the patch
> > correctly, they don't need to read the README anymore.
>
> That's correct for this time.  However, if they have other kernel
> trees (in the future) with this patch applied, it can help.
>
> > Seriously, without knowing about the pre-patches, what would you expect
> > about the patch order if you found the patches 2.6.8, 2.6.8.1, 2.6.9?
>
> We have evidence that it's confusing to more than one person.

Using 2.6.8-fix1 instead of 2.6.8.1 could avoid such problems.
--
vda

