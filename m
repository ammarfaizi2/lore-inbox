Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbTJAXOv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 19:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbTJAXOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 19:14:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:48027 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262629AbTJAXOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 19:14:50 -0400
Date: Wed, 1 Oct 2003 16:14:42 -0700
From: Chris Wright <chrisw@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: Rik van Riel <riel@redhat.com>, Chris Wright <chrisw@osdl.org>,
       torvalds@osdl.org, greg@kroah.com, linux-kernel@vger.kernel.org,
       vserver@solucorp.qc.ca
Subject: Re: sys_vserver
Message-ID: <20031001161442.B14425@osdlab.pdx.osdl.net>
References: <Pine.LNX.4.44.0310011744030.19538-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.44.0310011852270.15287-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0310011852270.15287-100000@thoron.boston.redhat.com>; from jmorris@redhat.com on Wed, Oct 01, 2003 at 06:57:46PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James Morris (jmorris@redhat.com) wrote:
> I think virtualization is important/useful enough to warrant an API of
> it's own.  It could be similar to LSM, e.g.  allow pluggable
> virtualization modules, with no cost for the base kernel.

Doesn't sound like 2.6 material.
