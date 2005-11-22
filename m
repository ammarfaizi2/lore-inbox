Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbVKVNEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbVKVNEy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 08:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbVKVNEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 08:04:54 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:52180 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964865AbVKVNEx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 08:04:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qEYWufTyaMEcFlJwVtjiS+XvrXNvMi0NvNWEcdRJsbnFZftRWn6omGjJL5qR9Dh1xdYk/VPSsHLj9cn+SA76Pofo3HMAM12BFUtCfITYrS/hrI6SrFCBnsGpQx1OsNd9QW6G2oxH/NvMthCsrk6E1R4wjdNrUceoD6vLmtBATio=
Message-ID: <625fc13d0511220504h45ff660r1a5dd4e671881037@mail.gmail.com>
Date: Tue, 22 Nov 2005 07:04:52 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH] Add more SCM trees to MAINTAINERS
Cc: scjody@steamballoon.com, gregkh@suse.de, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <200511212236.43551.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <625fc13d0511211911j10f8e87dha9be0b71a298c60d@mail.gmail.com>
	 <200511212236.43551.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> On Monday 21 November 2005 22:11, Josh Boyer wrote:
> > IDE/ATAPI CDROM DRIVER
> > @@ -1279,6 +1286,7 @@ P:Vojtech Pavlik
> > M:vojtech@suse.cz
> > L:linux-input@atrey.karlin.mff.cuni.cz
> > L:linux-joystick@atrey.karlin.mff.cuni.cz
> > +T:git kernel.org:/pub/scm/linux/kernel/git/dtor/input.git
> > S:Maintained
>
> This one is not really the official input tree as it is maintained by
> myself, not Vojtech. He is currently publishes his quilt patchset
> (a bit dated though) at:
>
>         http://www.ucw.cz/~vojtech/input/

Thanks.  I've fixed it up in my git tree.

josh
