Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbVCKWf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVCKWf6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 17:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVCKWf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 17:35:58 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:19410 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261656AbVCKWeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 17:34:03 -0500
Date: Fri, 11 Mar 2005 14:33:36 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Dave Jones <davej@redhat.com>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: AGP bogosities
Message-ID: <20050311223336.GB20551@taniwha.stupidest.org>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com> <20050311021248.GA20697@redhat.com> <16944.65532.632559.277927@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0503101839530.2530@ppc970.osdl.org> <87vf7xg72s.fsf@devron.myhome.or.jp> <20050311222614.GH4185@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050311222614.GH4185@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 05:26:14PM -0500, Dave Jones wrote:

> Does no-one read dmesg output any more?

For many people it's overly verbose and long --- so I assume they just
tune it out.

Sometimes I wonder if it would be a worth-while effort to trim the
dmesg boot text down to what users really *need* to know.  We could
retain most of the other stuff at a different log-level which would be
exposed by a kernel command line parameter or something during boot
for when people have problems.
