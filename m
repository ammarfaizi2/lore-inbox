Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267711AbUHJUbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267711AbUHJUbp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 16:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267722AbUHJUbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 16:31:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22985 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267711AbUHJUb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 16:31:26 -0400
Date: Tue, 10 Aug 2004 16:31:12 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: Chris Wright <chrisw@osdl.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Kurt Garloff <garloff@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] [LSM] Rework LSM hooks
In-Reply-To: <20040810131217.Q1924@build.pdx.osdl.net>
Message-ID: <Xine.LNX.4.44.0408101630250.9412-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2004, Chris Wright wrote:

> Thanks, James.  Since these are the only concrete numbers and they are
> in the noise, I see no compelling reason to change to unlikely().

There may be some way to make it ia64 specific.  Is it a cpu issue, or 
compiler?


- James
-- 
James Morris
<jmorris@redhat.com>


