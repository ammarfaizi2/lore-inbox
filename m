Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262627AbVGHFuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbVGHFuv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 01:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbVGHFuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 01:50:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20713 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262621AbVGHFtq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 01:49:46 -0400
Date: Fri, 8 Jul 2005 01:48:00 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Arjan van de Ven <arjan@infradead.org>
cc: serue@us.ibm.com, "Timothy R. Chavez" <tinytim@us.ibm.com>,
       Steve Grubb <sgrubb@redhat.com>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, <linux-audit@redhat.com>,
       <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Mounir Bsaibes <mbsaibes@us.ibm.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Klaus Weidner <klaus@atsec.com>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, Robert Love <rml@novell.com>,
       Christoph Hellwig <hch@infradead.org>,
       Daniel H Jones <danjones@us.ibm.com>, Amy Griffis <amy.griffis@hp.com>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: [PATCH] audit: file system auditing based on location and name
In-Reply-To: <1120800795.3249.5.camel@laptopd505.fenrus.org>
Message-ID: <Xine.LNX.4.44.0507080138380.15737-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jul 2005, Arjan van de Ven wrote:

> why not?
> If your /etc/shadow has no selinux context you've lost already :0

No, the kernel will map it to something safe.


- James
-- 
James Morris
<jmorris@redhat.com>


