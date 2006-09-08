Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWIHQES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWIHQES (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 12:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWIHQES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 12:04:18 -0400
Received: from mail.impinj.com ([206.169.229.170]:3465 "EHLO earth.impinj.com")
	by vger.kernel.org with ESMTP id S1750772AbWIHQER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 12:04:17 -0400
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [RFC] e-mail clients
Date: Fri, 8 Sep 2006 09:04:10 -0700
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <4500B2FB.8050805@vhugo.net> <200609081454.40522.hpj@urpla.net> <200609080918.47693.gene.heskett@verizon.net>
In-Reply-To: <200609080918.47693.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609080904.10997.vlobanov@speakeasy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 September 2006 06:18, Gene Heskett wrote:
> On Friday 08 September 2006 08:54, Hans-Peter Jansen wrote:
> >Am Freitag, 8. September 2006 10:24 schrieb Jesper Juhl:
> >> I personally use both 'pine' and 'kmail' and they both work perfectly
> >> for sending patches.
> >
> >With kmail, you have control over line breaks with Option -> Wrap lines,
> >which is useful for e.g. pasted syslog data, but remember to enable it
> >before writing the message, since you have to manually add line breaks
> >for the entered text too.
> >
> >Inlined patches should be added via Message -> Insert File to preserve
> >line breaks and white space.
>
> But be sure and turn word wrapping off before inserting the file, or
> pasting (usually bad I might add).  And my version of kmail wraps the
> whole document if the wrapping is turned back on, as it is now.  Which
> makes it rather frustrating.

Strange. I leave my KMail to word-wrap always, in which case Message -> Insert 
File automatically turns off any and all text munging when it is inserting 
the chosen file. No need to toggle any switches here, either before or after 
inserting.

FWIW, KMail 1.9.1 shipped with openSUSE 10.1

-- Vadim Lobanov
