Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbUKGRIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbUKGRIV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 12:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbUKGRIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 12:08:21 -0500
Received: from canuck.infradead.org ([205.233.218.70]:36370 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261471AbUKGRIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 12:08:19 -0500
Subject: RE: Possible GPL infringement in Broadcom-based routers
From: David Woodhouse <dwmw2@infradead.org>
To: davids@webmaster.com
Cc: "Jp@Enix. Org" <jp@enix.org>, linux-kernel@vger.kernel.org
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKGEIEPJAA.davids@webmaster.com>
References: <MDEHLPKNGKAHNMBLJOLKGEIEPJAA.davids@webmaster.com>
Content-Type: text/plain
Date: Sun, 07 Nov 2004 17:05:06 +0000
Message-Id: <1099847106.4938.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-11-06 at 12:09 -0800, David Schwartz wrote:
> 	This is exactly the argument I hoped would *not* arise on the LKML. I'll
> try not to reply further unelss someone posts something fundmanetally new.
> 
> > Anyone copying and distributing the Linux kernel must comply with the
> > copyright licence which _conditionally_ grants them permission to do so.
> 
> 	*sigh* We're not talking about anyone copying or distributing *the* Linux
> kernel. We're talking about someone copying or distributing another work
> that is derivative of the Linux kernel (which is also *a* Linux kernel, just
> not *the* Linux kernel). This is true whether they distribute the module
> separately or linked with the Linux kernel. In either case, they are not
> distributing the actual work placed under the GPL but a distinct, yet
> derivative, work.

Ah, OK. So as long as they change one line of code in the kernel, it's a
derivative work and they're no longer required to comply with the GPL?
They don't even need to use binary-only modules; they can put their own
proprietary code into their kernel, and distribute it how they like?

An interesting opinion.

-- 
dwmw2

