Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbUCLA6d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 19:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbUCLA6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 19:58:33 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:65242 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261880AbUCLA6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 19:58:30 -0500
Date: Fri, 12 Mar 2004 00:57:43 +0000
From: Dave Jones <davej@redhat.com>
To: Dax Kelson <dax@gurulabs.com>
Cc: Christophe Saout <christophe@saout.de>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LKM rootkits in 2.6.x
Message-ID: <20040312005743.GL28660@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Dax Kelson <dax@gurulabs.com>,
	Christophe Saout <christophe@saout.de>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200403112033.i2BKX9B6005538@eeyore.valparaiso.cl> <1079037332.8048.3.camel@leto.cs.pocnet.net> <20040311235021.GB21330@redhat.com> <1079052692.5345.0.camel@mentor.gurulabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079052692.5345.0.camel@mentor.gurulabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2004 at 05:51:33PM -0700, Dax Kelson wrote:
 > On Thu, 2004-03-11 at 16:50, Dave Jones wrote:
 > > On Thu, Mar 11, 2004 at 09:35:32PM +0100, Christophe Saout wrote:
 > > 
 > >  > > It _is_ forbidden. This isn't any kind of accident we are talking about,
 > >  > > this is out and out fraud.
 > >  > 
 > >  > I'm talking about binary modules, not rootkits. Vendors aren't doing
 > >  > forbidden things, are they?
 > > Yes.
 > What Vendors and modules?

Most recent one I saw was some 'antivirus' filescanning module.
The name escapes me. It was mentioned on l-k at the time.
It wasn't the first by any means however. This trick has been used
since vendors stopped exporting sys_call_table.

		Dave

