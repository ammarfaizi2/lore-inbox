Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263070AbVDLXxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263070AbVDLXxN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 19:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263045AbVDLXt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 19:49:27 -0400
Received: from lumumba.luc.ac.be ([193.190.9.252]:34319 "EHLO
	lumumba.luc.ac.be") by vger.kernel.org with ESMTP id S262586AbVDLXr2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 19:47:28 -0400
Date: Wed, 13 Apr 2005 01:48:02 +0200
To: David Eger <eger@havoc.gtf.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re: more git updates..
Message-ID: <20050412234802.GA13112@lumumba.luc.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050412223623.GA29088@havoc.gtf.org>
User-Agent: Mutt/1.5.6+20040907i
From: takis@lumumba.luc.ac.be (Panagiotis Issaris)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Tue, Apr 12, 2005 at 06:36:23PM -0400, David Eger wrote:
> > No. A tree is not the full data. A tree contains enough information
> > to 
> > _recreate_ the full data, but the tree itself just tells you _how_
> > to do 
> > that. It doesn't contain very much of the data itself at all.
> 
> Perhaps I'd understand this if you tell me what "recreate" means.
> If a have a SHA1 hash of a file, and I have the file, I can verify
> that said
> file has the SHA1 hash it's supposed to have, but I can't generate the
> file
> from it's hash...

But, but if you have that hexified SHA1 hash of a particular file you
want to access, there would be a file with a filename equal to that
hexified SHA1 hash which contained the compressed contents of the file
you're looking for.

At least, that's how I understood it...

With friendly regards,
Takis

-- 
OpenPGP key: http://lumumba.luc.ac.be/takis/takis_public_key.txt
fingerprint: 6571 13A3 33D9 3726 F728  AA98 F643 B12E ECF3 E029
