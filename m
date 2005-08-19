Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932761AbVHSXwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932761AbVHSXwS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 19:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932764AbVHSXwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 19:52:18 -0400
Received: from nproxy.gmail.com ([64.233.182.198]:44972 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932761AbVHSXwR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 19:52:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EkQCKiULAjKiCZJ4qxigdkvWcLHReFVkkc2qWHyTgTPhF/UkOfbCEKgE+04VE0v52WlUCk31KbMw/WzYom+Ic/z2SRU79KLJBgPYjM5V0rL6XZXMn742duf2JFkfyzoK4GIygLNt8faL+QMQ5PceLzVrpAgkU8eKoMJtCoMp3UE=
Message-ID: <58cb370e05081916523e96195e@mail.gmail.com>
Date: Sat, 20 Aug 2005 01:52:16 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [git patches] ide update
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linus Torvalds <torvalds@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <58cb370e050819165162278e61@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.GSO.4.62.0508182332470.22579@mion.elka.pw.edu.pl>
	 <1124406535.20755.12.camel@localhost.localdomain>
	 <58cb370e0508190202b0c5a5a@mail.gmail.com>
	 <1124474768.32050.4.camel@localhost.localdomain>
	 <58cb370e050819165162278e61@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/05, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> On 8/19/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > On Gwe, 2005-08-19 at 11:02 +0200, Bartlomiej Zolnierkiewicz wrote:
> > > lkml.org/lkml/2005/1/27/20
> > >
> > > AFAIK CS5535 driver was never ported to 2.6.x.  Somebody needs to
> > > port it to 2.6.x kernel, cleanup to match kernel coding standards and test.
> >
> > That was done some time ago and posted to various people.
> 
> This is a good news that cs5530 driver was ported.

s/cs5530/cs5535/
