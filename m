Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbVK3CnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbVK3CnU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 21:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbVK3CnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 21:43:20 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:16288 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750816AbVK3CnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 21:43:19 -0500
Date: Tue, 29 Nov 2005 18:43:07 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: dada1@cosmosbay.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shrinks dentry struct
Message-Id: <20051129184307.4eb4d419.pj@sgi.com>
In-Reply-To: <20051129181421.0e273d83.akpm@osdl.org>
References: <121a28810511282317j47a90f6t@mail.gmail.com>
	<20051129000916.6306da8b.akpm@osdl.org>
	<438C7218.8030109@cosmosbay.com>
	<20051129180653.f8d40e9a.pj@sgi.com>
	<20051129181421.0e273d83.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> Yes, but it's better to just do the big edit, rather than letting these
> little namespace crufties accumulate over time.

Ok.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
