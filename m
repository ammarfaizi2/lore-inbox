Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264082AbTI2R6k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264060AbTI2Ryq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:54:46 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:40185 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S264051AbTI2RyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:54:17 -0400
Date: Mon, 29 Sep 2003 18:53:55 +0100
From: Dave Jones <davej@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Correct address in MAINTAINERS
Message-ID: <20030929175355.GU5507@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <E1A41Rq-0000Mv-00@hardwired> <20030929175026.GE6526@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030929175026.GE6526@gtf.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 01:50:26PM -0400, Jeff Garzik wrote:
 > On Mon, Sep 29, 2003 at 06:04:34PM +0100, davej@redhat.com wrote:
 > > diff -urpN --exclude-from=/home/davej/.exclude bk-linus/MAINTAINERS linux-2.5/MAINTAINERS
 > > --- bk-linus/MAINTAINERS	2003-09-24 19:48:35.000000000 +0100
 > > +++ linux-2.5/MAINTAINERS	2003-09-24 20:19:53.000000000 +0100
 > > @@ -624,7 +624,7 @@ DIGIBOARD PC/XE AND PC/XI DRIVER
 > >  P:	Christoph Lameter
 > >  M:	christoph@lameter.com
 > >  W:	http://www.digi.com
 > > -L:	digilnux@dgii.com
 > > +L:	digilnux@digi.com
 > >  S:	Orphaned
 > 
 > Actually both addresses work equally well...

Ok, feel free to drop.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
