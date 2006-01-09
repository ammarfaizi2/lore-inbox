Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWAITXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWAITXv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 14:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWAITXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 14:23:51 -0500
Received: from kanga.kvack.org ([66.96.29.28]:13239 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751093AbWAITXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 14:23:50 -0500
Date: Mon, 9 Jan 2006 14:19:54 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS processes gettting stuck in D with currrent git
Message-ID: <20060109191954.GE16451@kvack.org>
References: <20060107050313.GA16451@kvack.org> <1136666794.7860.12.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136666794.7860.12.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 03:46:34PM -0500, Trond Myklebust wrote:
> Does a magic sysrq-t give any useful clues as to where they are hanging?

As of this afternoon's tree (6150c32589d1976ca8a5c987df951088c05a7542) 
after the more recent set of nfs patches, it seems to be behaving itself.  
Will keep sysrq enabled to see if it hits again, though.

		-ben
-- 
"You know, I've seen some crystals do some pretty trippy shit, man."
Don't Email: <dont@kvack.org>.
