Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbWJRQVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWJRQVQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWJRQVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:21:16 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:3751 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1751491AbWJRQVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:21:14 -0400
Date: Wed, 18 Oct 2006 10:21:14 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Al Viro <viro@ftp.linux.org.uk>,
       Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: dealing with excessive includes
Message-ID: <20061018162114.GU22289@parisc-linux.org>
References: <20061017005025.GF29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610161847210.3962@g5.osdl.org> <20061017043726.GG29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610170821580.3962@g5.osdl.org> <20061018044054.GH29920@ftp.linux.org.uk> <20061018091944.GA5343@martell.zuzino.mipt.ru> <20061018093126.GM29920@ftp.linux.org.uk> <Pine.LNX.4.64.0610180759070.3962@g5.osdl.org> <Pine.LNX.4.61.0610181814100.31301@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0610181814100.31301@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 06:15:27PM +0200, Jan Engelhardt wrote:
> So how about:
> 
> static inline void lock_super(struct super_block *sb)

Please start again at the top of the thread.  Thanks.
