Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbUCGJjL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 04:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbUCGJjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 04:39:11 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:13318 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261785AbUCGJjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 04:39:10 -0500
Date: Sun, 7 Mar 2004 09:39:06 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Dave Kleikamp <shaggy@austin.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Blaschke <blaschke@us.ibm.com>
Subject: Re: [PATCH] JFS DMAPI
Message-ID: <20040307093906.B14680@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Kleikamp <shaggy@austin.ibm.com>,
	Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Dave Blaschke <blaschke@us.ibm.com>
References: <1078444492.9162.56.camel@shaggy.austin.ibm.com> <20040305002046.GM1219@schnapps.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040305002046.GM1219@schnapps.adilger.int>; from adilger@clusterfs.com on Thu, Mar 04, 2004 at 05:20:46PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 05:20:46PM -0700, Andreas Dilger wrote:
> I'm sure Christoph will jump all over this (even though his name is in the
> code), so I thought I'd do it nicely first ;-).

My name is only in the compat wrappers for the IRIX synchronizcations
primites.  And the existance of those in code under fs/jfs just shows what
a huge hack this is..

