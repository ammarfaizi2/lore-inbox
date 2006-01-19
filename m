Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161436AbWASVle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161436AbWASVle (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 16:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161434AbWASVle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 16:41:34 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:5564 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161405AbWASVld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 16:41:33 -0500
Subject: Re: License oddity in some m68k files
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: linux-m68k@vger.kernel.org, geert@linux-m68k.org, zippel@linux-m68k.org,
       torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060119180947.GA25001@kroah.com>
References: <20060119180947.GA25001@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Jan 2006 21:40:12 +0000
Message-Id: <1137706812.8471.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-01-19 at 10:09 -0800, Greg KH wrote:
> Someone recently pointed out to me the following wording on some of the
> m68k files that reads:
> 
> |               Copyright (C) Motorola, Inc. 1990
> |                       All Rights Reserved
> |


You'll need to dig back through the archives but this was discussed and
resolved when the M68K merge was done or shortly afterwards. There is no
obvious problem with the licenses either. I believe Jes Sorensen did the
merge in question.

README

| You are hereby granted a copyright license to use, modify, and
| distribute the SOFTWARE so long as this entire notice is retained
| without alteration in any modified and/or redistributed versions,
| and that such modified versions are clearly identified as such.
| No licenses are granted by implication, estoppel or otherwise
| under any patents or trademarks of Motorola, Inc.

All Rights Reserved is not a problem since there is a license with it
"Not evidence blah" is not a problem because we have permission to
redistribute it.


