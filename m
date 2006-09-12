Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030368AbWILXeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030368AbWILXeg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 19:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030369AbWILXeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 19:34:36 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:35458 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030368AbWILXef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 19:34:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ctx29myBI0ezX/UNhJV4PuOgSP37iu0luBijD4HgRGAsjPN+cyGtDMSTPy4MvU5g0185fAX9gfzZFVi7+10O2ngVh8iz9fuJ38Vc91IlFYn2HhLmzB0ZVKd2Tq6kVQtMAAm7xVmOQBLRfu3vhCHlHH0qBj/JGx2Ua3R4nh5Od70=
Message-ID: <6bffcb0e0609121634l7db1808cwa33601a6628ee7eb@mail.gmail.com>
Date: Wed, 13 Sep 2006 01:34:34 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.18-rc6-mm2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060912162555.d71af631.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060912000618.a2e2afc0.akpm@osdl.org>
	 <6bffcb0e0609120554j5e69e2sd2c8ebb914c4c9f5@mail.gmail.com>
	 <6bffcb0e0609120842s6a38b326u4e1fff2e562a6832@mail.gmail.com>
	 <20060912162555.d71af631.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/06, Andrew Morton <akpm@osdl.org> wrote:
> On Tue, 12 Sep 2006 17:42:10 +0200
> "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
>
> > On 12/09/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > > On 12/09/06, Andrew Morton <akpm@osdl.org> wrote:
> > > >
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm2/
> > > >
> > >
> > > I get this while umounting jfs (umount segfaulted).
> >
> > s/jfs/xfs
>
> Do you mean that both JFS and XFS exhibit this bug, or only XFS?

Only XFS. (s/jfs/xfs - "Thinking in s/c++/sed :)")

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
