Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbWFAQgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbWFAQgT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 12:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbWFAQgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 12:36:18 -0400
Received: from a34-mta02.direcpc.com ([66.82.4.91]:4223 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S1030234AbWFAQgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 12:36:18 -0400
Date: Thu, 01 Jun 2006 12:35:44 -0400
From: Ben Collins <bcollins@ubuntu.com>
Subject: Re: 2.6.17-rc5-mm2
In-reply-to: <1149176945.3115.70.camel@laptopd505.fenrus.org>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux1394-devel@lists.sourceforge.net,
       bcollins@debian.org, scjody@modernduck.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Message-id: <1149179744.4533.205.camel@grayson>
Organization: Ubuntu
MIME-version: 1.0
X-Mailer: Evolution 2.6.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <20060601014806.e86b3cc0.akpm@osdl.org>
 <447F0905.8020600@gmail.com> <1149176945.3115.70.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-01 at 17:49 +0200, Arjan van de Ven wrote:
> On Thu, 2006-06-01 at 17:34 +0159, Jiri Slaby wrote:
> > Andrew Morton napsal(a):
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm2/
> > > 
> > Hello,
> > 
> > just another locking bug, I wonder if this wasn't discussed yet, but I can't
> > find it.
> > 
> 
> this appears to be a genuine bug:

Probably just dumb luck we haven't noticed it before. Thanks for the
catch.

-- 
Ubuntu     - http://www.ubuntu.com/
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
SwissDisk  - http://www.swissdisk.com/

