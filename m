Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965056AbVHJKbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbVHJKbR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 06:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbVHJKbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 06:31:17 -0400
Received: from gate.in-addr.de ([212.8.193.158]:40110 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S932543AbVHJKbR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 06:31:17 -0400
Date: Wed, 10 Aug 2005 12:30:41 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Christoph Hellwig <hch@infradead.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       David Teigland <teigland@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: [PATCH 00/14] GFS
Message-ID: <20050810103041.GB4634@marowsky-bree.de>
References: <20050802071828.GA11217@redhat.com> <20050809152045.GT29811@parcelfarce.linux.theplanet.co.uk> <20050810070309.GA2415@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050810070309.GA2415@infradead.org>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-08-10T08:03:09, Christoph Hellwig <hch@infradead.org> wrote:

> > Kindly lose the "Context Dependent Pathname" crap.
> Same for ocfs2.

Would a generic implementation of that higher up in the VFS be more
acceptable?

It's not like context-dependent symlinks are an arbitary feature, but
rather very useful in practice.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

