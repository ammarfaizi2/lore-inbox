Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965509AbWJ3TxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965509AbWJ3TxX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 14:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965454AbWJ3TxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 14:53:22 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:41154 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965517AbWJ3TxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 14:53:21 -0500
Date: Mon, 30 Oct 2006 11:53:05 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: LKML <linux-kernel@vger.kernel.org>, ppc-dev <linuxppc-dev@ozlabs.org>,
       paulus@samba.org, ak@suse.de, linux-mm@kvack.org, pj@sgi.com
Subject: Re: [PATCH 1/2] Create compat_sys_migrate_pages.
In-Reply-To: <20061030181701.23ea7cba.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.64.0610301152040.21342@schroedinger.engr.sgi.com>
References: <20061030181701.23ea7cba.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2006, Stephen Rothwell wrote:

> This is needed on bigendian 64bit architectures.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Christoph Lameter <clameter@sgi.com>
