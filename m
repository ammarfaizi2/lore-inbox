Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265950AbUFTVOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265950AbUFTVOS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 17:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265951AbUFTVN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 17:13:59 -0400
Received: from [213.146.154.40] ([213.146.154.40]:49628 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265950AbUFTVLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 17:11:54 -0400
Date: Sun, 20 Jun 2004 22:11:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jeremy <jeremy.katz@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
       Andrew Morton <akpm@osdl.org>, Linus <torvalds@osdl.org>,
       linuxppc64-dev@lists.linuxppc.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PPC64 iSeries viodasd proc file
Message-ID: <20040620211143.GA8368@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeremy <jeremy.katz@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@osdl.org>, Linus <torvalds@osdl.org>,
	linuxppc64-dev@lists.linuxppc.org,
	LKML <linux-kernel@vger.kernel.org>
References: <20040618165436.193d5d35.sfr@canb.auug.org.au> <40D305B4.4030009@pobox.com> <20040618151753.GA21596@infradead.org> <cb5afee1040620125272ab9f06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb5afee1040620125272ab9f06@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2004 at 03:52:33PM -0400, Jeremy wrote:
> It was in the tree for the platform, not just vendor trees.  ie,
> anyone who wanted to use the platform with Linux would have had this
> functionality.  If you'd argue that people shouldn't do that, then how
> are platforms supposed to get to a point where they can be included in
> the mainline tree?

Doesn't matter.  There was a really crappy 2.4 driver that IBM didn't
even bother to submit.  So for us it simply doesn't matter it existed.

Stop whining and ensure you're employer doesn't apply broken IBM patches
instead.

