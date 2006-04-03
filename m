Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWDCHic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWDCHic (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 03:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbWDCHic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 03:38:32 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62477 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964786AbWDCHib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 03:38:31 -0400
Date: Mon, 3 Apr 2006 08:38:26 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       pavel@ucw.cz
Subject: Re: Linux 2.6.17-rc1
Message-ID: <20060403073825.GB13275@flint.arm.linux.org.uk>
Mail-Followup-To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	pavel@ucw.cz
References: <Pine.LNX.4.64.0604022037380.3781@g5.osdl.org> <20060403141325.b4ccc5f4.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060403141325.b4ccc5f4.kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2006 at 02:13:25PM +0900, KAMEZAWA Hiroyuki wrote:
> On Sun, 2 Apr 2006 20:47:06 -0700 (PDT)
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > 
> > Ok, 
> >  it's two weeks since 2.6.16, and the merge window is closed.
> > 
> 
> Because my original patch was buggy and not tested, arm cannot work.
> This is a fix patch.
> 
> Is this Okay? > Russell-san

NAK.  See my mail in Pavel's thread on this subject.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
