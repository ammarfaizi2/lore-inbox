Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268881AbUHZN6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268881AbUHZN6I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 09:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268914AbUHZN6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 09:58:08 -0400
Received: from nysv.org ([213.157.66.145]:48014 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S268881AbUHZN54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 09:57:56 -0400
Date: Thu, 26 Aug 2004 16:56:22 +0300
To: Rik van Riel <riel@redhat.com>
Cc: Hans Reiser <reiser@namesys.com>, Jeremy Allison <jra@samba.org>,
       Christoph Hellwig <hch@lst.de>, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826135622.GY1284@nysv.org>
References: <412DA26C.5060604@namesys.com> <Pine.LNX.4.44.0408260927100.26316-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0408260927100.26316-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.5.6i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 09:27:52AM -0400, Rik van Riel wrote:
>
>1) how do you back up and restore files with streams inside ?

With a program that supports files with streams inside.

>2) how do standard unix utilities handle them ?

Most likely they don't ;) That is, until they are fixed or replaced.
I've heard of people who want xattrs to be backed up so they use star, 
not gnu tar, already.

-- 
mjt

