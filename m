Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751449AbWJRJ2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWJRJ2R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 05:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbWJRJ2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 05:28:17 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:29107 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751454AbWJRJ2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 05:28:16 -0400
Date: Wed, 18 Oct 2006 02:27:47 -0700
From: Paul Jackson <pj@sgi.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: akpm@osdl.org, jsipek@fsl.cs.sunysb.edu, linux-kernel@vger.kernel.org,
       hch@infradead.org, mhalcrow@us.ibm.com, penberg@cs.helsinki.fi,
       linux-fsdevel@vger.kernel.org
Subject: Re: fsstack: struct path
Message-Id: <20061018022747.d1d9ee5c.pj@sgi.com>
In-Reply-To: <20061018092241.GL29920@ftp.linux.org.uk>
References: <20061018042323.GA8537@filer.fsl.cs.sunysb.edu>
	<20061018013103.4ad6311a.akpm@osdl.org>
	<20061018013551.3745e1d5.akpm@osdl.org>
	<20061018090623.GK29920@ftp.linux.org.uk>
	<20061018021222.2c4d907c.akpm@osdl.org>
	<20061018092241.GL29920@ftp.linux.org.uk>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> struct path_node

or just struct pathnode ?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
