Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbUK3JN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbUK3JN5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 04:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbUK3JN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 04:13:56 -0500
Received: from 4s.enrico.unife.it ([192.167.219.82]:34998 "EHLO
	quatresse.ferrara.linux.it") by vger.kernel.org with ESMTP
	id S261876AbUK3JNu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 04:13:50 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: 2.6.10-rc2-mm2 usb storage still oopses
Date: Tue, 30 Nov 2004 10:13:45 +0100
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, Pete Zaitcev <zaitcev@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
References: <200411182203.02176.cova@ferrara.linux.it> <20041129163231.33affbde.akpm@osdl.org> <1101784930.2022.116.camel@mulgrave>
In-Reply-To: <1101784930.2022.116.camel@mulgrave>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200411301013.46888.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 04:22, martedì 30 novembre 2004, James Bottomley ha scritto:


> > >
> > > This looks as if SCSI falls victim of the general problem which ub
> > > addresses with the following fragment:
> >
> > Guys, is this problem still present in Linus's tree?  If so, is a fix for
> > 2.6.10 looking feasible?
>
> Al Viro has a tentative one at
>
> http://ftp.linux.org.uk/pub/people/viro/register_disk-hack
>
> If someone could try it out and verify that it fixes the problem, we
> could put it in.


Now I'm at work; this evening I'll try and I'll report asap the results. on 
wich kernel does it apply? last kernels that I've tried are 2.6.10-rcX-mmY 
series, but I can try the most suitable version for debugging, just let me 
know.



-- 
Fabio "Cova" Coatti    http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
