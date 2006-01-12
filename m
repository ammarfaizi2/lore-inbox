Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161333AbWALV4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161333AbWALV4D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 16:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161334AbWALV4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 16:56:01 -0500
Received: from canuck.infradead.org ([205.233.218.70]:49887 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1161335AbWALVz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 16:55:59 -0500
Subject: Re: git status (was: drm tree for 2.6.16-rc1)
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, airlied@linux.ie,
       linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>,
       Jens Axboe <axboe@suse.de>, Steven French <sfrench@us.ibm.com>,
       Roland Dreier <rolandd@cisco.com>, Wim Van Sebroeck <wim@iguana.be>,
       Anton Altaparmakov <aia21@cantab.net>,
       Dominik Brodowski <linux@dominikbrodowski.net>
In-Reply-To: <20060112134255.29074831.akpm@osdl.org>
References: <Pine.LNX.4.58.0601120948270.1552@skynet>
	 <Pine.LNX.4.64.0601121016020.3535@g5.osdl.org>
	 <20060112134255.29074831.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 21:55:45 +0000
Message-Id: <1137102945.3621.1.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 13:42 -0800, Andrew Morton wrote:
> audit: we're tracking one oops which seems to be coming out of the
> audit code

Are we? I recall one oops which was tracked down to an inode which had
i_sb == 0x00000008 so it didn't seem to be audit-related. Was there
something else I should be looking at?

-- 
dwmw2

