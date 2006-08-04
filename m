Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161537AbWHDW2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161537AbWHDW2n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 18:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161538AbWHDW2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 18:28:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1670 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161537AbWHDW2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 18:28:42 -0400
Date: Fri, 4 Aug 2006 18:28:26 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andreas Schwab <schwab@suse.de>, Alexey Dobriyan <adobriyan@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: single bit flip detector.
Message-ID: <20060804222826.GE18792@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Andreas Schwab <schwab@suse.de>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060801223011.GF22240@redhat.com> <20060801223622.GG22240@redhat.com> <20060801230003.GB14863@martell.zuzino.mipt.ru> <20060801231603.GA5738@redhat.com> <jebqr4f32m.fsf@sykes.suse.de> <20060801235109.GB12102@redhat.com> <20060802001626.GA14689@redhat.com> <20060804141955.3139b20b.akpm@osdl.org> <20060804220644.GA28344@redhat.com> <20060804152507.0abae1df.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060804152507.0abae1df.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 03:25:07PM -0700, Andrew Morton wrote:
 > On Fri, 4 Aug 2006 18:06:44 -0400
 > Dave Jones <davej@redhat.com> wrote:
 > 
 > > Does it still work ? :-)
 > 
 > Awww man.  And I thought everyone _else_ was being fussy.
 > 
 > I expect it'll work.  We'll find out when someone hits a single-bit error.
 > The worst it can do is crash the machine, except it's already crashed...

Ok, if it turns out to be broken, and my version worked, you owe
me a beer at the next conference :-)

Apathetically-Signed-off-by: Dave Jones <davej@redhat.com>

		Dave

-- 
http://www.codemonkey.org.uk
