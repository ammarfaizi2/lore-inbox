Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932579AbVHJWee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbVHJWee (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 18:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbVHJWee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 18:34:34 -0400
Received: from pat.uio.no ([129.240.130.16]:19925 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932579AbVHJWed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 18:34:33 -0400
Subject: Re: [RFC][PATCH] Rename PageChecked as PageMiscFS
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Daniel Phillips <phillips@arcor.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Hugh Dickins <hugh@veritas.com>,
       David Howells <dhowells@redhat.com>
In-Reply-To: <200508110823.53593.phillips@arcor.de>
References: <42F57FCA.9040805@yahoo.com.au>
	 <20050808145430.15394c3c.akpm@osdl.org>
	 <200508110812.59986.phillips@arcor.de>
	 <200508110823.53593.phillips@arcor.de>
Content-Type: text/plain
Date: Wed, 10 Aug 2005 18:34:18 -0400
Message-Id: <1123713258.10292.109.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.067, required 12,
	autolearn=disabled, AWL 0.93, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 11.08.2005 Klokka 08:23 (+1000) skreiv Daniel Phillips:
> Note: I have not fully audited the NFS-related colliding use of page flags bit 
> 8, to verify that it really does not escape into VFS or MM from NFS, in fact 
> I have misgivings about end_page_fs_misc which uses this flag but has no 
> in-tree users to show how it is used and, hmm, isn't even _GPL.  What is up?

What "NFS-related colliding use of page flags bit 8"?

Cheers,
  Trond

