Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbVBXA3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbVBXA3O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 19:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVBXA0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 19:26:54 -0500
Received: from mail.aei.ca ([206.123.6.14]:15322 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261728AbVBXAUQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 19:20:16 -0500
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: 2.6.11-rc4-mm1
Date: Wed, 23 Feb 2005 19:20:03 -0500
User-Agent: KMail/1.7.2
Cc: "J.A. Magallon" <jamagallon@able.es>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20050223014233.6710fd73.akpm@osdl.org> <200502231812.07882.tomlins@cam.org> <200502231840.06017.dtor_core@ameritech.net>
In-Reply-To: <200502231840.06017.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502231920.03298.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 February 2005 18:40, Dmitry Torokhov wrote:
> On Wednesday 23 February 2005 18:12, Ed Tomlinson wrote:
> > On Wednesday 23 February 2005 17:38, J.A. Magallon wrote:
> > > 
> > > On 02.23, Andrew Morton wrote:
> > > > 
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc4/2.6.11-rc4-mm1/
> > > > 
> > > > 
> > > > - Various fixes and updates all over the place.  Things seem to have slowed
> > > >   down a bit.
> > > > 
> > > > - Last, final, ultimate call: if anyone has patches in here which are 2.6.11
> > > >   material, please tell me.
> > > > 
> > > 
> > > Two points:
> > > 
> > > - I lost my keyboard :(. USB, but plugged into PS/2 with an adapter.
> > 
> > Mine too.  Details sent in another message...
> > 
> 
> Does i8042.nopnp help?

Dmitry,  Yes it works fine with this kernel parm.  I run with hotplug on and udev off.

Andrew, 11-bk is also fine (without the parm).

Thanks
Ed Tomlinson
