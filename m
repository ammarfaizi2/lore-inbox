Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264126AbTLJVMF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 16:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264127AbTLJVMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 16:12:05 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:44811
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S264126AbTLJVMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 16:12:00 -0500
Date: Wed, 10 Dec 2003 13:05:57 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Linus Torvalds <torvalds@osdl.org>, Maciej Zenczykowski <maze@cela.pl>,
       David Schwartz <davids@webmaster.com>,
       Jason Kingsland <Jason_Kingsland@hotmail.com>,
       linux-kernel@vger.kernel.org
Subject: RE: Linux GPL and binary module exception clause?
In-Reply-To: <Pine.LNX.4.58.0312102202090.30959@earth>
Message-ID: <Pine.LNX.4.10.10312101300030.3805-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ingo,

I have and the lawyers tell me that it is one or the other and can not be
both.  So explain to me how a GPL/BSD or BSD/GPL works again?

Also if one does an md5sum on the "COPYING" file from FSF and compares it
from the one in the kernel source they differ.

Since the original version from FSF protects the content inside because it
protects the shell of the file, bridge point to stating the kernel is w/o
a license is relativily  easy.  I will have to re-read the "original
COPYING" file from FSF for version 1 and version 2.

Not sure but could the veil of GPL be now pierced because of the simple
additions to the top of "COPYING" ?

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Wed, 10 Dec 2003, Ingo Molnar wrote:

> 
> On Wed, 10 Dec 2003, Andre Hedrick wrote:
> 
> > Then the trick is when does the license flip modes?
> > Compile time?
> > Execution time?
> 
> a license does not 'trigger' or 'flip'. Either the full source code is
> licensed under the GPL (by the copyright holders) or not.
> 
> a given piece of code might be licensed under an infinite number of other
> licenses as well, but this doesnt matter a bit, as long as the GPL is one
> of them.
> 
> > This starts to become more fuzzy than I care to look at right now.
> 
> then ask a lawyer.
> 
> 	Ingo
> 

