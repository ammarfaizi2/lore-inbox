Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbTFIVrK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 17:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTFIVrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 17:47:09 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:30853 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262013AbTFIVrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 17:47:08 -0400
Date: Tue, 10 Jun 2003 00:00:43 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Timothy Miller <miller@techsource.com>
Cc: Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Coding standards.  (Was: Re: [PATCH] [2.5] Non-blocking write can block)
Message-ID: <20030609220043.GB17033@wohnheim.fh-wedel.de>
References: <Pine.HPX.4.33L.0306040144400.8930-100000@punch.eng.cam.ac.uk> <20030604065336.A7755@infradead.org> <3EDE0E85.7090601@techsource.com> <20030607001202.GB14475@kroah.com> <3EE4B4C3.80902@techsource.com> <20030609163959.GA13811@wohnheim.fh-wedel.de> <3EE4D5A5.1070303@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3EE4D5A5.1070303@techsource.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 June 2003 14:44:53 -0400, Timothy Miller wrote:
> 
> But we have a practical goal in mind here.  Not only does something have 
> to WORK (compile to working machine code), but our grandchildren, using 
> Linux 20.14.6 are going to have to be able to make sense out of what we 
> wrote.  Were it not for the fact that Linux is a collaborative project, 
> we would not need these standards.

Nice picture.  That implies that coding standards don't matter for
device drivers for some short-lived hardware like drivers/cdrom/ but
do a lot more for core code like mm/.

All right, let's stop beating the grass while there is still a shadow
of the dead horse remaining.

Jörn

-- 
Write programs that do one thing and do it well. Write programs to work
together. Write programs to handle text streams, because that is a
universal interface. 
-- Doug MacIlroy
