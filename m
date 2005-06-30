Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbVF3LNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVF3LNf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 07:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbVF3LNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 07:13:35 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:11224 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261644AbVF3LN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 07:13:29 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: FUSE merging?
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1120126804.3181.34.camel@laptopd505.fenrus.org>
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu>
	 <20050630022752.079155ef.akpm@osdl.org>
	 <E1Dnvhv-0000SK-00@dorka.pomaz.szeredi.hu>
	 <1120125606.3181.32.camel@laptopd505.fenrus.org>
	 <E1Dnw2J-0000UM-00@dorka.pomaz.szeredi.hu>
	 <1120126804.3181.34.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Thu, 30 Jun 2005 12:13:15 +0100
Message-Id: <1120129996.5434.1.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-30 at 12:20 +0200, Arjan van de Ven wrote:
> On Thu, 2005-06-30 at 12:12 +0200, Miklos Szeredi wrote:
> > > if you are so interested in getting fuse merged... why not merge it
> > > first with the security stuff removed entirely. And then start
> > > discussing putting security stuff back in ?
> > 
> >   a) it's already been discussed to death (just search for 'fuse' on
> >      lkml and fsdevel)
> > 
> >   b) I don't consider it a good idea to ship a defunct version of it in
> >      the mainline
> > 
> > Can you please accept my wish to have FUSE merged _with_ the
> > unprivileged mount's thing.
> 
> By the same argument:
> Then can you please accept that FUSE will not get merged right now.

Why should he?  IMNSHO it should be merged right now with the security
stuff.  FUSE works as is.  Without the security stuff FUSE is useless.

I have yet to read even a single constructive argument why it should not
be merged as is.

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

