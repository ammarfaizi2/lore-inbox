Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbTIEOIR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 10:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262778AbTIEOIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 10:08:17 -0400
Received: from imap.gmx.net ([213.165.64.20]:2261 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262771AbTIEOIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 10:08:15 -0400
Subject: Re: [2.6.0-test-x] Kernel Oops and pppd segfault
From: Florian Zimmermann <florian.zimmermann@gmx.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030905084126.A15120@infradead.org>
References: <1062711059.8011.4.camel@mindfsck>
	 <20030905084126.A15120@infradead.org>
Content-Type: text/plain
Message-Id: <1062769373.3377.1.camel@mindfsck>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 05 Sep 2003 15:42:54 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-09-05 at 09:41, Christoph Hellwig wrote:
> On Thu, Sep 04, 2003 at 11:30:59PM +0200, Florian Zimmermann wrote:
> > I have posted that to linux-ppp mailing list, but
> > no answer for 2 weeks now..
> 
> This should fix the oops, but the failure is still strange.
   ^^^^^ what? where? when?
In case you attached a patch, please resend - there was no
attachement :)

> 
> do you already have a ppp device in /dev before loading the module?

the module is never loaded btw, but before i try to load the
module the /device is already there:

crw-r--r--    1 root     root     108,   0 Sep  5  2003 /dev/ppp




