Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbUBHByA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 20:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbUBHByA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 20:54:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45236 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261744AbUBHBx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 20:53:59 -0500
Date: Sat, 7 Feb 2004 20:53:53 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Valdis.Kletnieks@vt.edu, <linux-kernel@vger.kernel.org>,
       <sds@epoch.ncsc.mil>
Subject: Re: 2.6.2-mm1, selinux, and initrd
In-Reply-To: <20040207173102.07b0e932.akpm@osdl.org>
Message-ID: <Xine.LNX.4.44.0402072053350.20875-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Feb 2004, Andrew Morton wrote:

> Valdis.Kletnieks@vt.edu wrote:
> >
> > On Sat, 07 Feb 2004 08:49:28 EST, James Morris said:
> > 
> > > Ok, looks like a problem where devfs is passing an empty string to 
> > > do_mount when it expects a page.
> > > 
> > > Please try the patch below against 2.6.2-mm1.
> > 
> > OK, thanks.. that's a "confirmed working"...
> > 
> 
> 
> So I queue up the below patch, yes?

Yes, please.



- James
-- 
James Morris
<jmorris@redhat.com>


