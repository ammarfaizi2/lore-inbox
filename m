Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWFTUuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWFTUuG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 16:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbWFTUuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 16:50:05 -0400
Received: from xenotime.net ([66.160.160.81]:36822 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751013AbWFTUuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 16:50:04 -0400
Date: Tue, 20 Jun 2006 13:52:49 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch -mm 20/20 RFC] chardev: GPIO for SCx200 & PC-8736x: add
 sysfs-GPIO interface
Message-Id: <20060620135249.7f13d042.rdunlap@xenotime.net>
In-Reply-To: <44985D51.8050200@gmail.com>
References: <448DB57F.2050006@gmail.com>
	<cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
	<44944D14.2000308@gmail.com>
	<20060619222223.8f5133a9.akpm@osdl.org>
	<44985321.3020609@gmail.com>
	<20060620131440.9c9b0999.rdunlap@xenotime.net>
	<44985D51.8050200@gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 14:40:49 -0600 Jim Cromie wrote:

> Randy.Dunlap wrote:
> > On Tue, 20 Jun 2006 13:57:21 -0600 Jim Cromie wrote:
> >
> >   
> >> Andrew Morton wrote:
> >>     
> >>> On Sat, 17 Jun 2006 12:42:28 -0600
> >>> Jim Cromie <jim.cromie@gmail.com> wrote:
> >>>
> >>> Fixup patches agains next -mm would be suitable.  Please keep them
> >>> super-short: basically one-patch-per-review-comment.  That way I can easily
> >>> instertion-sort the patches into place and we retain a nice patch series.
> >>>
> >>>   
> >>>       
> >> OK.  Just so Im clear, Ill patch against the tail of the set (ie -mm1), 
> >> and you'll push them forward into the
> >>     
> >
> > WTH?  "you'll" ??
> >
> >   
> 
> are we talking apostrophes here, or division of labor ?
> If the latter, what have I missed ?
> Andrew specifically said 'patch against next -mm', I intended to follow 
> his instructions.

apostrophes :)

and ISTM that you didn't follow his request.

---
~Randy
