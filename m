Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbWFLRUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWFLRUe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWFLRUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:20:34 -0400
Received: from admin.zirkelwireless.com ([209.216.203.65]:19354 "EHLO
	admin.zirkelwireless.com") by vger.kernel.org with ESMTP
	id S1751119AbWFLRUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:20:32 -0400
Subject: Re: [Linux-fbdev-devel] [PATCH 0/7] Detaching fbcon
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <a5d587fb0606120946n7bbc2a41jd489efaff6742fe8@mail.gmail.com>
References: <44856223.9010606@gmail.com> <448C19D7.5010706@t-online.de>
	 <448C83AD.9060200@gmail.com> <448D1C9E.7050606@t-online.de>
	 <448D5B4F.5080504@gmail.com>
	 <a5d587fb0606120628o203941c3h761bfffbb6ec08f7@mail.gmail.com>
	 <1150122011.5693.17.camel@thor.lorrainebruecke.local>
	 <a5d587fb0606120946n7bbc2a41jd489efaff6742fe8@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Organization: Tungsten Graphics
Date: Mon, 12 Jun 2006 19:20:26 +0200
Message-Id: <1150132826.5693.71.camel@thor.lorrainebruecke.local>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 18:46 +0200, Michal Suchanek wrote:
> On 6/12/06, Michel Dänzer <michel@tungstengraphics.com> wrote:
> > On Mon, 2006-06-12 at 15:28 +0200, Michal Suchanek wrote:
> > >
> > > I like the possibility to change X resolution using fbset (from inside
> > > X). I use it to correct problems caused by crashed X programs that
> > > change resolution. But I run X with the UseFbDev option.
> >
> > Still, you should use something like xrandr instead, so the X server
> > knows about it.
> 
> I have never heared of a tool for X that does it.

Well, now you have. :) Unless you have a different problem, but xrandr
has always worked for me in the situations you describe above.


-- 
Earthling Michel Dänzer           |          http://tungstengraphics.com
Libre software enthusiast         |          Debian, X and DRI developer


