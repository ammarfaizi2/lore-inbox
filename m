Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269491AbUHZUJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269491AbUHZUJX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269532AbUHZUGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:06:14 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:50563 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269535AbUHZT70 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:59:26 -0400
Date: Thu, 26 Aug 2004 12:58:36 -0700
From: Paul Jackson <pj@sgi.com>
To: mjt@nysv.org (Markus   =?ISO-8859-1?Q?T=F6rnqvist?=)
Cc: riel@redhat.com, reiser@namesys.com, jra@samba.org, hch@lst.de,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com, torvalds@osdl.org,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-Id: <20040826125836.06e26561.pj@sgi.com>
In-Reply-To: <20040826135622.GY1284@nysv.org>
References: <412DA26C.5060604@namesys.com>
	<Pine.LNX.4.44.0408260927100.26316-100000@chimarrao.boston.redhat.com>
	<20040826135622.GY1284@nysv.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus wrote:
> >2) how do standard unix utilities handle them ?
> 
> Most likely they don't ;) That is, until they are fixed or replaced.

Not good, in my view.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
