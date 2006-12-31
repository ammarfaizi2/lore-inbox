Return-Path: <linux-kernel-owner+w=401wt.eu-S933207AbWLaURH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933207AbWLaURH (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 15:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933210AbWLaURH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 15:17:07 -0500
Received: from xenotime.net ([66.160.160.81]:60697 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933207AbWLaURG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 15:17:06 -0500
Date: Sun, 31 Dec 2006 12:03:45 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       trivial@kernel.org
Subject: Re: [PATCH] Documentation: Explain a second alternative for
 multi-line macros.
Message-Id: <20061231120345.6baccd97.rdunlap@xenotime.net>
In-Reply-To: <20061231200903.GF3730@rhun.ibm.com>
References: <Pine.LNX.4.64.0612311430370.18269@localhost.localdomain>
	<20061231194501.GE3730@rhun.ibm.com>
	<Pine.LNX.4.64.0612311447030.18368@localhost.localdomain>
	<20061231200903.GF3730@rhun.ibm.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Dec 2006 22:09:03 +0200 Muli Ben-Yehuda wrote:

> On Sun, Dec 31, 2006 at 02:49:48PM -0500, Robert P. J. Day wrote:
> 
> > there would appear to be *lots* of cases where the ({ }) notation is
> > used when nothing is being returned.  i'm not sure you can be that
> > adamant about that distinction at this point.
> 
> IMHO, the main point of CodingStyle is to clarify how new code should
> be written and old code should've been written.

I agree.  We aren't trying to "fix" ancient history.

---
~Randy
