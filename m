Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263112AbTCWQjJ>; Sun, 23 Mar 2003 11:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263113AbTCWQjJ>; Sun, 23 Mar 2003 11:39:09 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:52749 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263112AbTCWQjI>; Sun, 23 Mar 2003 11:39:08 -0500
Date: Sun, 23 Mar 2003 16:50:12 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
cc: Jurriaan <thunder7@xs4all.nl>, <linux-kernel@vger.kernel.org>,
       <vandrove@vc.cvut.cz>
Subject: Re: 2.6.65 + matrox framebuffer: life is good!
In-Reply-To: <20030323120949.GA5002@hh.idb.hist.no>
Message-ID: <Pine.LNX.4.44.0303231649170.5720-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Fri, Mar 21, 2003 at 07:43:37PM +0100, Jurriaan wrote:
> > Just to let people know there's a new version of Petr's ongoing work
> > with the matrox framebuffer available:
> > 
> > ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/
> > 
> > the file is called mga-2.5.65.gz, and it works wonderfully.
> > 
> > As far as I know, this patch was only announced on the fbdev-developers
> > mailing-list. I assume there are more matrox-users here.
> > 
> It applies fine to 2.5.65-mm3 too.
> Is this something that could be mergerd?  The current
> matrox driver don't even compile.

Its for testing and it hasn't been fully ported over yet. Its close. 
I was busy fixing higher level bugs but now that most are fixed I can work 
on the matrox driver again.


