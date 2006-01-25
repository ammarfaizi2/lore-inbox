Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbWAYI4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWAYI4y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 03:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbWAYI4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 03:56:54 -0500
Received: from xproxy.gmail.com ([66.249.82.203]:39074 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750926AbWAYI4x convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 03:56:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L+1ryxfL8eoY6Df0EHasadJeBVQHQ3SZjq62l3y1kQE1phHSOpatZRS6zjVvh8VEEuu/9U3DgAwqQQgI/6etMeu1xaKsul57s9YJVKY+6OLMkAreoV1ureECysF8EYdghUQ9M57twQle0r/3RoMW1Ym8EvBCWFhMeWMx1a6uhcc=
Message-ID: <3d53b7120601250056s77e876b6l2ac6781b8a9c9f00@mail.gmail.com>
Date: Wed, 25 Jan 2006 14:26:51 +0530
From: Syed Ahemed <kingkhan@gmail.com>
To: Diego Calleja <diegocg@gmail.com>
Subject: Re: Patch for CVE-2004-1334 ???
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060123191439.cfe5d61c.diegocg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <3d53b7120601230939p6e8906fbtb196ab49b9b028c5@mail.gmail.com>
	 <20060123191439.cfe5d61c.diegocg@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The simple reason we do not intend to use the latest version is we run
some third party software which cant be front ported (pardon the slang
) to 2.4.29 and above.
As for the changeset by  guninski , i wish to ask about a one point
source of applying all the patches for 2.4.28 .I mean shouldn't all
the kernel security patches ( atleast the ones that have become CVE's)
be a part of kernel.org .Since there isn't any what is the reason ?
I dont want to go to Gentoo for one patch , red hat for another
....and GOD knows how many sites .
Torvalds is the GOD of open source , but am i asking for too much :-)





On 1/23/06, Diego Calleja <diegocg@gmail.com> wrote:
> El Mon, 23 Jan 2006 23:09:49 +0530,
> Syed Ahemed <kingkhan@gmail.com> escribió:
>
> > Hi
> > I do know this community is busy with more important things , but i am
> > out of ideas/search  on this one.
> > How do i get the patch for the CVE-2004-1334 ? I have an opensource
>
> Well, 2.4.32 fixes that bug and many others security. Any reason why you
> aren't using the latest version.
>
> You can find links to the changesets in the original security advisory
> from guninski (easy to find in google)
>
