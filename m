Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265791AbUFRXcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265791AbUFRXcn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 19:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265773AbUFRXcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 19:32:22 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:56223 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265786AbUFRXby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 19:31:54 -0400
Date: Sat, 19 Jun 2004 00:30:15 +0100
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cross-sparse
Message-ID: <20040618233015.GA12063@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.58.0406172304170.1495@waterleaf.sonytel.be> <Pine.LNX.4.58.0406180925210.4669@ppc970.osdl.org> <20040618213338.GA4975@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040618213338.GA4975@MAIL.13thfloor.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 11:33:38PM +0200, Herbert Poetzl wrote:

 > I did an 'extensive' search with google (you do not want 
 > to know how many hits you get with 'sparse') and read 
 > most postings on the sparse mailinglist (linux-sparse),
 > found the freshmeat project pointing me to the 'new url'
 > http://www.codemonkey.org.uk/projects/sparse/ where I can
 > download 'sparse-2003-11-27.tar.gz', then found out that
 > there should be a maintained (up to date) version of it at 
 > 
 >    http://www.kernel.org/pub/software/devel/sparse/
 > 
 > but what I find there, seems of no use to me ...
 > (I'm no bitkeeper person) so I'm still looking for an url
 > where I can get a recent .tar to install that beast.
 > 
 > can anybody point me in the right direction, please?

Erk, that's where I originally was snapshotting stuff, then
the box hosting codemonkey.org.uk died, and I had to restore
from backup. It turned a symlink to http://www.codemonkey.org.uk/projects/bitkeeper/sparse/
into a copy of the dir. Oops. I'll go fix that up (By just
killing the old dir).

		Dave

