Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263019AbUEWHMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbUEWHMg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 03:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbUEWHMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 03:12:36 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:43942 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S263019AbUEWHMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 03:12:35 -0400
From: Michael Neuffer <neuffer@neuffer.info>
Date: Sun, 23 May 2004 10:12:37 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.7-rc1
Message-ID: <20040523081237.GA22525@neuffer.info>
References: <Pine.LNX.4.58.0405222331200.18534@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405222331200.18534@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Linus Torvalds (torvalds@osdl.org):
> 
> Hmm.. This is stuff all over the map, but most interesting (or at least
> most "core") is probably the merging of the NUMA scheduler and the anonvma
> rmap code. The latter gets rid of the expensive pte chains, and instead
> allows reverse page mapping by keeping track of which vma (and offset)  
> each page is associated with. Special kudos to Andrea Arcangeli and Hugh
> Dickins.

Hmmmm..... no new patch on kernel.org yet.
Have you been too busy to upload it ?


Cheers
   Mike
