Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267299AbTBKSLm>; Tue, 11 Feb 2003 13:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267452AbTBKSLm>; Tue, 11 Feb 2003 13:11:42 -0500
Received: from host194.steeleye.com ([66.206.164.34]:41481 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267299AbTBKSLm>; Tue, 11 Feb 2003 13:11:42 -0500
Subject: Re: 2.5.60: sim710.c doesn't compile
From: James Bottomley <James.Bottomley@steeleye.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030211181600.GP17128@fs.tum.de>
References: <Pine.LNX.4.44.0302101103570.1348-100000@penguin.transmeta.com>
	 <20030211181600.GP17128@fs.tum.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 11 Feb 2003 12:21:25 -0600
Message-Id: <1044987686.1774.15.camel@mulgrave>
Mime-Version: 1.0
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-11 at 12:16, Adrian Bunk wrote:
> On Mon, Feb 10, 2003 at 11:08:28AM -0800, Linus Torvalds wrote:
> >...
> > Summary of changes from v2.5.59 to v2.5.60
> > ============================================
> >...
> > James Bottomley <james.bottomley@steeleye.com>:
> >...
> >   o [SCSI] Migrate sim710 to 53c700 chip driver
> >...
> 
> This change broke the compilation of sim710.c:

This is actually already fixed in the current linux-scsi tree.

James



