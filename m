Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262563AbVAUXBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbVAUXBX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 18:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbVAUXBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 18:01:22 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:3194 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262563AbVAUXAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 18:00:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=I5cGbYEG38fX2AVtg8iYv+YEL6665u2D5bS/3GxlM+DrE64fyk687TgpwA56avSrt+pwMMmycUmB1sFbEwCyaljGYLvnPJa5RRT/eHHRU+h53S8X3CFdjKu7vw6W3hBklFdUa4OxYvM514bC/cTvDAMEsRx5S4P1VIA17cS9gMM=
Message-ID: <58cb370e05012115003865ce18@mail.gmail.com>
Date: Sat, 22 Jan 2005 00:00:35 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [BK PATCHES] ide-dev-2.6 update
Cc: linux-ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050121221308.GA3321@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <58cb370e0501211202372c9b1b@mail.gmail.com>
	 <20050121221308.GA3321@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2005 14:13:08 -0800, Greg KH <greg@kroah.com> wrote:
> On Fri, Jan 21, 2005 at 09:02:39PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > Hi,
> >
> > ide-dev-2.6 tree has been resurrected.  It now contains first bunch
> > of fixes needed for converting IDE device drivers to driver-model.
> 
> Yeah!
> 
> > NOTE: If you have a local copy of the tree please re-clone it, thanks.
> >
> > BK users:
> >
> >       bk pull bk://bart.bkbits.net/ide-dev-2.6
> 
> Hm, have a patch anywhere that people can look at?

I sent patches to linux-ide (since they are highly IDE specific and I
don't want to
spam LKML too much) some time ago but since they are not that big I will resend
them here...

[ I don't make patch versions of ide-dev because it is pulled into -mm ]

Bartlomiej
