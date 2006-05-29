Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbWE2Htu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWE2Htu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 03:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWE2Htu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 03:49:50 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:11686 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1750752AbWE2Htt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 03:49:49 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17530.42626.693182.834140@gargle.gargle.HOWL>
Date: Mon, 29 May 2006 11:45:06 +0400
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.16.18 - spelling fix
Newsgroups: gmane.linux.kernel
In-Reply-To: <17530.11036.427239.812677@cse.unsw.edu.au>
References: <Pine.LNX.4.64.0605272016520.28903@p34>
	<17530.11036.427239.812677@cse.unsw.edu.au>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown writes:
 > On Saturday May 27, jpiszcz@lucidpixels.com wrote:
 > > I was experimenting with Linux SW raid today and found a spelling error 
 > > when reading the help menus...
 > > 
 > > Patch attached, not sure if this is the right place to send it or if 
 > > patches go to Andrew Morton (misc ones like this)...
 > 
 > Thanks....
 > but more helpful than a spelling fix would be a chunk of elisp that I
 > could stick in my .emacs, which would automatically turn on flyspell
 > mode in Kconfig files, and inside comments in .c and .h files.

(defun linux-c-mode ()
  ...
  (flyspell-prog-mode)
  ...)

 > 
 > The first bit is probably trivial.  The second has got to be
 > possible...
 > 
 > Or maybe just keep posting patches like this in the hope of shaming
 > people like me into learning how to spell....
 > 
 > ;-)
 > 
 > Thanks.
 > 
 > NeilBrown

Nikita.
