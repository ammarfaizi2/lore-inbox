Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264700AbUEOQnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264700AbUEOQnZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 12:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264701AbUEOQnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 12:43:25 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:13509 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S264700AbUEOQnY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 12:43:24 -0400
From: Duncan Sands <baldrick@free.fr>
To: Nuno Ferreira <nuno.ferreira@graycell.biz>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: PATCH: (as279) Don't delete interfaces until all are unbound
Date: Sat, 15 May 2004 18:43:21 +0200
User-Agent: KMail/1.5.4
Cc: Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sf.net
References: <Pine.LNX.4.44L0.0405131352500.651-100000@ida.rowland.org> <1084636220.2901.1.camel@taz.graycell.biz>
In-Reply-To: <1084636220.2901.1.camel@taz.graycell.biz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405151843.21710.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, I've now tested the patch ant it appears to work, I removed the USB
> modem several times and not a single Oops to report.

Thanks for testing.  The fix is in Linus's tree, so the next kernel release will
have it.

All the best,

Duncan.
