Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbVA1Rit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVA1Rit (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 12:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVA1Ris
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 12:38:48 -0500
Received: from ns.suse.de ([195.135.220.2]:53222 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261499AbVA1Rhe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 12:37:34 -0500
Date: Fri, 28 Jan 2005 18:37:23 +0100
From: Olaf Hering <olh@suse.de>
To: dtor_core@ameritech.net
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: Re: atkbd_init lockup with 2.6.11-rc1
Message-ID: <20050128173723.GA4169@suse.de>
References: <20050128132202.GA27323@suse.de> <20050128135827.GA28784@suse.de> <d120d50005012806435a17fe98@mail.gmail.com> <20050128145511.GA29340@suse.de> <d120d500050128072268a5c2f0@mail.gmail.com> <20050128161746.GA1092@suse.de> <d120d500050128084345bb1abd@mail.gmail.com> <d120d500050128093472935f8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d120d500050128093472935f8a@mail.gmail.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Jan 28, Dmitry Torokhov wrote:

> On Fri, 28 Jan 2005 11:43:44 -0500, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > This time  keyboard does not hang but NAKs everything instead...
> 
> Probably stupid question - does this box have AT keyboard? Or NAKs are
> perfectly valid?

There is nothing connected. 2.6.10-bk11 works, -bk12 not. Thats a
starting point, will look at the differences now.
