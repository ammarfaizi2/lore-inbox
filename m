Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317436AbSGJOlx>; Wed, 10 Jul 2002 10:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317437AbSGJOlw>; Wed, 10 Jul 2002 10:41:52 -0400
Received: from 216-42-72-141.ppp.netsville.net ([216.42.72.141]:32800 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S317436AbSGJOlv>; Wed, 10 Jul 2002 10:41:51 -0400
Subject: Re: reiserfsprogs release
From: Chris Mason <mason@suse.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Steven Cole <elenstev@mesatop.com>, Vitaly Fertman <vitaly@namesys.com>,
       reiserfs-list@namesys.com, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20020710153801.A8570@infradead.org>
References: <200206251829.25799.vitaly@namesys.com>
	<20020625165254.GA30301@matrix.wg> <200206261317.10813.vitaly@namesys.com>
	<200207101206.48370.vitaly@namesys.com>
	<1026311034.7074.76.camel@spc9.esa.lanl.gov> 
	<20020710153801.A8570@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 10 Jul 2002 10:44:32 -0400
Message-Id: <1026312272.5663.227.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-10 at 10:38, Christoph Hellwig wrote:
> On Wed, Jul 10, 2002 at 08:23:54AM -0600, Steven Cole wrote:
> > On Wed, 2002-07-10 at 02:06, Vitaly Fertman wrote:
> > > 
> > > Hi all,
> > > 
> > > the latest reiserfsprogs-3.6.2 is available on our ftp site.
> > > 
> > 
> > Is the following patch to Documentation/Changes appropriate?
> 
> Does reiserfs in 2.4.19-pre require that version?  if yes it would be
> very bad (2.4 is not supposed to need newer userlevel during the series)

No, it does not require that version.  It is a good idea since fsck
improves with each release though ;-)

-chris


