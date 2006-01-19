Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422671AbWASWPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422671AbWASWPX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 17:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422668AbWASWPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 17:15:23 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:5284 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422667AbWASWPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 17:15:21 -0500
Subject: Re: License oddity in some m68k files
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-m68k@vger.kernel.org,
       geert@linux-m68k.org, torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060119220431.GA4739@kroah.com>
References: <20060119180947.GA25001@kroah.com>
	 <Pine.LNX.4.61.0601192014010.30994@scrub.home>
	 <20060119220431.GA4739@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Jan 2006 22:14:56 +0000
Message-Id: <1137708896.8471.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-01-19 at 14:04 -0800, Greg KH wrote:
> Ah, ok, thanks, that makes sense.  How about a simple pointer to the
> license info from the .S files to the README file so that people (like
> me), don't get confused again?  I've attached a patch below if you wish
> to apply it.
> 
They specifically ask as is their right within the GPL that you note if
you modify the files. Otherwise seems fine.


