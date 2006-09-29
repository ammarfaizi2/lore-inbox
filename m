Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750915AbWI3FMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbWI3FMK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 01:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbWI3FMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 01:12:10 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:53450 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750915AbWI3FMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 01:12:07 -0400
Subject: Re: GPLv3 Position Statement
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, tridge@samba.org
In-Reply-To: <r6ven6oox6.fsf@skye.ra.phy.cam.ac.uk>
References: <1159498900.3880.31.camel@mulgrave.il.steeleye.com>
	 <17692.46192.432673.743783@samba.org> <17692.46192.432673.743783@samba.org>
	 <1159515085.3880.78.camel@mulgrave.il.steeleye.com>
	 <r6ven6oox6.fsf@skye.ra.phy.cam.ac.uk>
Content-Type: text/plain
Date: Fri, 29 Sep 2006 16:50:43 -0400
Message-Id: <1159563043.9543.39.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-29 at 13:08 +0100, Sanjoy Mahajan wrote:
> > However, once they comply with the distribution requirements,
> > they're free to do whatever they want with the resulting OS in their
> > printer ... including checking for only HP authorised ink
> > cartridges.  You can take exception to this check and not buy the
> > resulting printer, but you can't tell them not to do the check
> > without telling them how they should be using the embedded platform.
> 
> I don't see where the GPLv3 forbids such checks.  Which section are
> you thinking of?  In my understanding, it says only that HP must give
> users the keys to install modified software.  From section 1 (of the
> July draft):

This was an illustration of the difference between use and distribution.
I don't claim GPLv3 limits these activities; I was just using the
example I was given.

>   The Corresponding Source also includes any encryption or
>   authorization keys necessary to install and/or execute modified
>   versions from source code in the recommended or principal context of
>   use, such that they can implement all the same functionality in the
>   same range of circumstances.
> 
> So the user, having the keys, can remove the cartridge check.  HP
> might not like it and may choose not to distribute GPLv3 software with
> the printer, but that's a separate story.

Under GPLv3, yes.  That's one of the fulcrums of the argument.  As one
of the copyright holders, I don't want to get into the business of
dictating terms for uses to which linux (or other open source software)
is put.  I fundamentally don't want to require in the copyright licence
that device manufacturers using embedded linux have to give me the key.
I'd love to persuade them why modifiable hardware is a good thing
(linksys WRT54GL) and give them market reasons for allowing it.  But I
don't want to compel them.  The pragmatic reason is that to impose
compulsion I have to forsee all the end uses (this is why we get
drafting issues with the GPLv3).   However, the moral reason is that I
believe this type of compulsion to be wrong in principle: it acts as a
damper on innovation if everyone has to keep looking over their shoulder
and considering what my wishes might be in software they use.
Fundamentally, I want people to do things I never even dreamed of with
my software.

James


