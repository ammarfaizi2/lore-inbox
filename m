Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267352AbUHYNO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267352AbUHYNO4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 09:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267368AbUHYNO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 09:14:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39850 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267352AbUHYNOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 09:14:55 -0400
Date: Wed, 25 Aug 2004 09:14:21 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Miles Bader <miles@gnu.org>
cc: Stephen Smalley <sds@epoch.ncsc.mil>, Greg KH <greg@kroah.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][7/7] add xattr support to ramfs
In-Reply-To: <buoy8k3pumq.fsf@mctpc71.ucom.lsi.nec.co.jp>
Message-ID: <Xine.LNX.4.44.0408250913570.25088-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2004, Miles Bader wrote:

> 
> I've gotten the impression that ramfs is simpler and lighter-weight than
> tmpfs, but doesn't have some features like resource-limiting.

tmpfs can also be swapped.


- James
-- 
James Morris
<jmorris@redhat.com>


