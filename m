Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVBQXQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVBQXQZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 18:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVBQXOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 18:14:12 -0500
Received: from 0.fe-0-0-0.c1.pfn.citynetwireless.net ([209.218.71.2]:17033
	"EHLO core.citynetwireless.net") by vger.kernel.org with ESMTP
	id S261225AbVBQXNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 18:13:25 -0500
Date: Thu, 17 Feb 2005 17:13:04 -0600
From: parker@citynetwireless.net
To: arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Please open sysfs symbols to proprietary modules
Message-ID: <20050217231304.GA18940@core.citynetwireless.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Feb 2005 09:41:00 +0100, Arjan van de Ven <arjan@infradead.org> wrote:
> On Wed, 2005-02-02 at 17:56 -0500, Pavel Roskin wrote:
> > Hello!
> >
> > I'm writing a module under a proprietary license.  I decided to use sysfs
> > to do the configuration.  Unfortunately, all sysfs exports are available
> > to GPL modules only because they are exported by EXPORT_SYMBOL_GPL.
> 
> I suggest you talk to a lawyer and review the general comments about
> binary modules with him (http://people.redhat.com/arjanv/COPYING.modules
> for example). You are writing an addition to linux from scratch, and it
> is generally not considered OK to do that in binary form (I certainly do
> not consider it OK).

So what about companies like ImageStream who write proprietary Linux network
drivers for their hardware from scratch with no previous ports from another OS?
